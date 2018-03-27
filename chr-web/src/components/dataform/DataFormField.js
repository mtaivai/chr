import React, { Component } from 'react';
import PropTypes from "prop-types";
import DataForm from './DataForm';
import PropertyUtils from './PropertyUtils';

import {
    Container,
    Row,
    Col,
    Nav as R_Nav,
    NavItem as R_NavItem,
    NavLink as R_NavLink,
    Button,
    Form,
    FormGroup,
    Label,
    Input,
    FormText} from 'reactstrap';

import validate from 'validate.js';


import './DataFormField.css';
import DataFormUtils from "./DataFormUtils";


const _LOG_DEBUG = true;
const _LOG_INFO = true;
const _LOG_ERROR = true;


class DataFormField extends Component {
    constructor(props) {
        super(props);

        this.handleChange = this.handleChange.bind(this);
        this.handleBlur = this.handleBlur.bind(this);
        //this.getFormObject = this.getFormObject.bind(this);
        //this.getValue = this.getValue.bind(this);
        //this.getFromPropsOrContext = this.getFromPropsOrContext.bind(this);

        this.getValue = this.getValue.bind(this);
        this.setValue = this.setValue.bind(this);

        this.validate = this.validate.bind(this);
        this.validateValue = this.validateValue.bind(this);
        this.commit = this.commit.bind(this);

        this.state = {
            inputValid: true,
            validationErrors: [],
            validated: false,
            dirty: false
        };

        this.bindObj = {
            commit: this.commit,
            validate: this.validate,
            getValue: this.getValue,
            setValue: this.setValue
        };
    }

    componentWillMount() {
        // Late binding of the 'value' because we don't have the context
        // available in the constructor

        if (typeof this.props.bind === 'function') {
            this.props.bind(this.bindObj);
        } else if (typeof this.props.bind !== 'undefined') {
            console.error("Invalid 'bind' property (not a function)", this.props.bind);
        }

        DataFormUtils.connectParent(this.context.formParent, this);

        this.setState({
            value: this.getModelValue()
        });
    }

    componentWillUnmount() {
        DataFormUtils.disconnectParent(this.context.formParent, this);
    }


    getFromPropsOrContext(propName, contextName) {

        let val = this.props[propName];
        if (typeof val === 'undefined' || val === null) {
            if (typeof contextName === 'undefined' || contextName === null) {
                contextName = propName;
            }
            val = this.context[contextName];
        }
        return val;
    }

    getFormObject() {
        return this.getFromPropsOrContext('formObject', 'formObject');
    }
    isViewMode() {
        return this.getFromPropsOrContext('viewMode', 'formViewMode');
    }
    isHorizontal() {
        return this.getFromPropsOrContext('horizontal', 'formHorizontal');
    }
    isInlineEdit() {
        return this.getFromPropsOrContext('inlineEdit', 'formInlineEdit');
    }
    getColumns() {
        return this.getFromPropsOrContext('columns', 'formColumns');
    }
    getConstraints() {
        return this.getFromPropsOrContext('constraints', 'formConstraints');
    }
    getAutoCommit() {
        return this.getFromPropsOrContext('autoCommit', 'formAutoCommit');
    }

    getThisFieldConstraints(defaultValue) {
        const constraints = this.getConstraints();
        if (typeof constraints !== 'object') {
            return defaultValue;
        } else {
            const fieldConstraints = constraints[this.props.name];
            return (typeof fieldConstraints === 'object') ? fieldConstraints : defaultValue;
        }
    }

    getModelValue(props, context) {


        if (typeof this.props.value !== 'undefined' && this.props.value !== null) {
            return this.props.value;
        }
        const formObject = this.getFormObject(props, context);

        if (!formObject) {
            if (_LOG_ERROR) console.error("No 'formObject' defined");
            return null;
        } else if (!this.props.name) {
            if (_LOG_ERROR) console.error("No 'name' defined");
            return null;
        } else {
            return PropertyUtils.getValue(formObject, this.props.name);
        }
    }

    getColumns(childIndex) {
        let columns = this.context.formColumns;

        if (typeof columns === 'undefined' || columns === null) {
            columns = {}
        } else {
            if (Array.isArray(columns)) {
                let index = childIndex;
                if (!index) {
                    index = 0;
                }
                if (index < columns.length) {
                    columns = columns[index];
                } else {
                    columns = {}
                }
            }
        }

        if (this.props.xs) {
            columns.xs = this.props.xs;
        }
        if (this.props.sm) {
            columns.sm = this.props.sm;
        }
        if (this.props.md) {
            columns.md = this.props.md;
        }
        if (this.props.lg) {
            columns.lg = this.props.lg;
        }
        if (this.props.xl) {
            columns.xl = this.props.xl;
        }

        return columns;
    }

    makeGridClasses(columns) {
        let className = "";


        if (columns.xs) {
            className += (" col-" + columns.xs);
        }
        if (columns.sm) {
            className += (" col-sm-" + columns.sm);
        }
        if (columns.md) {
            className += (" col-md-" + columns.md);
        }
        if (columns.lg) {
            className += (" col-lg-" + columns.lg);
        }
        if (columns.xl) {
            className += (" col-xl-" + columns.xl);
        }

        return className;
    }


    commit() {

        if (!this.state.inputValid) {
            return false;
        }
        const value = this.state.value;
        const formObject = this.getFormObject();
        const propName = this.props.name;

        if (_LOG_DEBUG) console.log("Commit value to '" + propName + "': " + value);
        PropertyUtils.setValue(formObject, propName, value);
        this.setState({
            dirty: false
        });
        // TODO call parent dirtyStateChanged!

        return true;

    }

    validate(options) {
        // If this validation call is a result of trickle down from parent due to event from this
        // component validation, return the original result:
        const existingResult = DataFormUtils.stopRecursiveValidation(this, options);
        if (existingResult !== null) {
            if (_LOG_DEBUG) console.log("Already validated field: " + this.props.name);
            return existingResult;
        }

        return this.validateValue(this.state.value, options);
    }
    validateValue(value, options) {
        // const formObject = this.getFormObject();
        if (_LOG_DEBUG) console.log("Validate field: " + DataFormUtils.getComponentName(this), options);

        if (typeof options === 'undefined' || options === null) {
            options = {};
        }

        const propName = this.props.name;

        let validationErrors;
        let inputValid;

        const constraints = this.getThisFieldConstraints();
        if (typeof constraints !== 'undefined' && constraints !== null) {
            // Validate

            const validateObject = {
                [propName]: value
            };
            const propConstraints = {
                [propName]: constraints
            };

            const allErrors = validate(validateObject, propConstraints);
            if (typeof(allErrors) !== 'undefined') {
                const propErrors = allErrors[propName];
                validationErrors = {
                    [propName]: propErrors
                };
                inputValid = (typeof propErrors === 'undefined')
                    || propErrors === null
                    || propErrors.length === 0;
            } else {
                validationErrors = [];
                inputValid = true;
            }

        } else {
            inputValid = true;
            validationErrors = [];
        }

        const stateChanged = !this.state.validated || (this.state.inputValid !== inputValid);

        const result = {
            inputValid: inputValid,
            hasErrors: !inputValid,
            validationErrors: validationErrors
        };

        if (_LOG_DEBUG) console.log("Validation result for field " + DataFormUtils.getComponentName(this) + ": " + this.state.inputValid + " --> " + inputValid, result, options);

        // Force state update
        if (options.setState) {
            this.setState(result);
        }

        if (!this.state.validated) {
            this.setState({
                validated: true,
                ...result
            });
        }

        if (stateChanged && (typeof options.fireEvents === 'undefined' || options.fireEvents === null || options.fireEvents)) {
            if (typeof this.props.validationStateChanged === 'function') {
                this.props.validationStateChanged(result);
            }
            // Notify parent
            const parent = this.context.formParent;
            if (typeof parent === 'object' && typeof parent.childValidationStateChanged === 'function') {
                parent.childValidationStateChanged(result, this);
            }

        }

        return result;
    }

    handleChange(event) {
        this.setValue(event.target.value);
    }

    getValue() {
        return this.state.value;
    }
    setValue(value) {
        console.log("setValue: " + this.props.name + " = " + value, this.state);

        const modelValue = this.getModelValue();

        const validationResult = this.validateValue(value, {});
        const autoCommit = this.getAutoCommit();

        this.setState({
            value: value,
            dirty: value !== modelValue,
            ...validationResult
        });

        // TODO call parent dirtyStateChanged!


        if (autoCommit === true
            || (autoCommit === 'valid' && validationResult.inputValid)) {
            this.commit();
        }
        console.log("*setValue: " + value, this.state);

    }


    handleBlur(event) {
        this.validate({setState: true});
    }

    render() {

        const name = this.props.name;
        const label = this.props.label;
        // const value = this.props.value;

        const horizontal = this.isHorizontal();
        const viewMode = this.isViewMode();
        const inlineEdit = this.isInlineEdit();


        let wrapperClassName = "DataFormField form-group col";

        if (horizontal) {
            wrapperClassName += " horizontal";
        } else {
            wrapperClassName += " vertical";
        }

        if (viewMode) {
            wrapperClassName += " view-mode";
        }


        const index = this.props.groupChildIndex;

        wrapperClassName += (" " + this.makeGridClasses(this.getColumns(index)));


        const invalidClassName = "is-invalid";
        const validClassName = "is-valid";
        const requiredClassName = "required";
        const modifiedClassName = "modified";

        const renderFormControl = (appendClassName) => {

            let className = "form-control";
            if (appendClassName) {
                className += " " + appendClassName;
            }

            // const value = this.getModelValue() || "";
            const value = this.state.value || "";
            if (viewMode) {

                return (
                    <span className={className}>
                        <span className={"form-field-value"}>{value}</span>
                        {inlineEdit && <a className={"edit-field-value"} href={"#"}>Muokkaa</a>}
                    </span>
                );
            } else {

                let type = this.props.type;

                if (type === 'custom') {
                    return <div className={"custom-input"}>{this.props.children}</div>;
                } else {
                    return (
                        <Input className={className} type={type} value={value}
                               onChange={this.handleChange}
                               onBlur={this.handleBlur}
                               valid={this.state.inputValid}>
                            {this.props.children}
                        </Input>
                    );

                }


            }
        };

        const renderFeedback = () => {
            // this.state.inputValid
            if (this.state.inputValid) {
                // return (
                //     <div className={"valid-feedback"}>
                //         Looks good!
                //     </div>
                // );
                return null;
            } else {
                console.log("this.state", this.state);
                const errors = (typeof this.state.validationErrors !== 'undefined' && this.state.validationErrors !== null)
                    ? this.state.validationErrors[this.props.name] : null;


                if (typeof errors !== 'undefined' && errors !== null && errors.length > 0) {
                    let msg;
                    if (errors.length > 1) {
                        const items = [];
                        for (let i = 0; i < errors.length; i++) {
                            items.push(<li key={i}>{errors[i]}</li>);
                        }
                        msg = (
                            <ul>
                                {items}
                            </ul>
                        );
                    } else {
                        msg = (<span>{errors[0]}</span>);
                    }
                    return (
                        <div className={"invalid-feedback"}>
                            {msg}
                        </div>
                    );
                } else {
                    return null;
                }

            }

        };

        const renderFormGroup = (className, labelClassName, controlWrapperClassName) => {


            if (!className) {
                className = "";
            }

            let appendClassName = "";
            if (this.state.dirty) {
                appendClassName += " " + modifiedClassName;
            }

            let required = false;
            const constraints = this.getThisFieldConstraints({});

            if (typeof constraints.presence !== 'undefined' && constraints.presence !== null
                && constraints.presence !== false) {
                required = true;
            } else if (typeof constraints.length !== 'undefined' && constraints.length !== null
                && (constraints.length.min > 0 || constraints.length.is > 0)) {
                required = true;
            }

            if (required) {
                appendClassName += " " + requiredClassName;
            }

            if (this.state.validated && this.state.inputValid) {
                appendClassName += " " + validClassName;
            } else if (this.state.validated) {
                appendClassName += " " + invalidClassName;
            }

            if (appendClassName) {
                className += " " + appendClassName;
            }


            return (
                <div className={className}>
                    <label className={labelClassName || "col-form-label"}>{label}</label>
                    <div className={controlWrapperClassName || ""}>
                        { renderFormControl() }
                        { renderFeedback() }
                    </div>
                </div>
            );
        };

        if (horizontal) {
            return (
                <div className={wrapperClassName}>
                    {
                        renderFormGroup(
                            "form-row",
                            "col-form-label col-xs-12 col-sm-5 col-md-3 col-lg-2",
                            "col-xs-12 col-sm-7 col-md-9 col-lg-10")
                    }
                </div>
            );
        } else {
            return renderFormGroup(wrapperClassName, "col-form-label", "");
        }

    }
}
DataFormField.propTypes = {
    formObject: PropTypes.object,
    name: PropTypes.string,
    label: PropTypes.string,
    value: PropTypes.any,
    horizontal: PropTypes.bool,
    viewMode: PropTypes.bool,
    inlineEdit: PropTypes.bool,
    groupChildIndex: PropTypes.number,

    type: PropTypes.oneOf(["text", "select", "custom"]),

    xs: PropTypes.number,
    sm: PropTypes.number,
    md: PropTypes.number,
    lg: PropTypes.number,
    xl: PropTypes.number,

    constraints: DataForm.propTypes.constraints,
    autoCommit: DataForm.propTypes.autoCommit,
    validationStateChanged: PropTypes.func,

    // Bind receives object of following shape:
    // {
    //    commit: function(),
    //    validate: function(options),
    //    getValue: function(), // only for fields
    //    setValue: function(value) // only for fields
    // }
    bind: PropTypes.func,

};

DataFormField.defaultProps = {
};

DataFormField.contextTypes = {
    formParent: DataForm.childContextTypes.formParent,
    formObject: PropTypes.object,
    formHorizontal: PropTypes.bool,
    formViewMode: PropTypes.bool,
    formInlineEdit: PropTypes.bool,
    formColumns: DataForm.childContextTypes.formColumns,

    formConstraints: DataForm.childContextTypes.formConstraints,
    formAutoCommit: DataForm.childContextTypes.formAutoCommit
};

export default DataFormField;