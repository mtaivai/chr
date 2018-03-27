import React, { Component } from 'react';
import PropTypes from "prop-types";
import DataForm from './DataForm';
import DataFormField from './DataFormField';
import DataFormUtils from "./DataFormUtils";

import validate from 'validate.js';


class DataFormGroup extends Component {

    constructor(props) {
        super(props);

        this.commitListeners = [];
        this.validateListeners = [];

        this.commit = this.commit.bind(this);
        this.validate = this.validate.bind(this);
        this.childValidationStateChanged = this.childValidationStateChanged.bind(this);

        this.state = {
            validated: false,
            hasErrors: false
        };

        this.bindObj = {
            commit: this.commit,
            validate: this.validate
        };
    }

    componentWillMount() {
        if (typeof this.props.bind === 'function') {
            this.props.bind(this.bindObj);
        } else if (typeof this.props.bind !== 'undefined') {
            console.error("Invalid 'bind' property (not a function)", this.props.bind);
        }

        DataFormUtils.connectParent(this.context.formParent, this);
    }

    componentWillUnmount() {
        DataFormUtils.disconnectParent(this.context.formParent, this);
    }

    getChildContext() {

        return {
            formParent: this,
            formObject: this.getFormObject(),
            formHorizontal: this.isHorizontal(),
            formViewMode: this.isViewMode(),
            formInlineEdit: this.isInlineEdit(),
            formColumns: this.getColumns(),
            formConstraints: this.getConstraints(),
            formAutoCommit: this.getAutoCommit()
        };
    }

    addCommitListener(listener) {
        this.commitListeners.push(listener);
    }
    removeCommitListener(listener) {
        for (let i = 0; i < this.commitListeners.length; i++) {
            if (this.commitListeners[i] === listener) {
                this.commitListeners.splice(i, 1);
            }
        }
    }

    addValidateListener(listener) {
        // console.log("***", listener);
        this.validateListeners.push(listener);
    }
    removeValidateListener(listener) {
        for (let i = 0; i < this.validateListeners.length; i++) {
            if (this.validateListeners[i] === listener) {
                this.validateListeners.splice(i, 1);
            }
        }
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



    commit() {
        return DataFormUtils.groupCommit(this.commitListeners);
    }

    validate(options) {
        return DataFormUtils.groupValidate(this, options);
    }

    childValidationStateChanged(result, source) {
        return DataFormUtils.handleChildValidationStateChanged(this, result, source);
    }

    render() {


        let className = "DataFormGroup form-row";
        if (this.isHorizontal()) {
            className += " horizontal";
        }
        if (this.isViewMode()) {
            className += " view-mode";
        }

        if (this.state.hasErrors) {
            className += " is-invalid";
        } else {
            className += " is-valid";
        }

        const wrappedChildren = [];
        React.Children.forEach(this.props.children, (child, i) => {

            if (child.type === DataFormField) {
                // Wrap with properties
                const extProps = {
                    groupChildIndex: i,
                    ...child.props
                };
                wrappedChildren.push(<DataFormField key={i} {...extProps}/>);
            } else {
                wrappedChildren.push(child);

            }
        }, this);


        return (
            <div className={className}>
                {wrappedChildren}
            </div>
        );
    }
}
DataFormGroup.propTypes = {
    name: PropTypes.string,
    formObject: PropTypes.object,
    horizontal: PropTypes.bool,
    viewMode: PropTypes.bool,
    inlineEdit: PropTypes.bool,
    columns: DataForm.propTypes.columns,
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

DataFormGroup.defaultProps = {
};

DataFormGroup.contextTypes = {
    formParent: DataForm.childContextTypes.formParent,
    formObject: PropTypes.object,
    formHorizontal: PropTypes.bool,
    formViewMode: PropTypes.bool,
    formInlineEdit: PropTypes.bool,

    formColumns: DataForm.childContextTypes.formColumns,

    formConstraints: DataForm.childContextTypes.formConstraints,
    formAutoCommit: DataForm.childContextTypes.formAutoCommit
};

DataFormGroup.childContextTypes = {
    formParent: DataFormGroup.contextTypes.formParent,
    formObject: PropTypes.object,
    formHorizontal: PropTypes.bool,
    formViewMode: PropTypes.bool,
    formInlineEdit: PropTypes.bool,

    formColumns: DataForm.childContextTypes.formColumns,

    formConstraints: DataFormGroup.contextTypes.formConstraints,
    formAutoCommit: DataFormGroup.contextTypes.formAutoCommit
};

export default DataFormGroup;