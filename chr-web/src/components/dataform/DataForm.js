import React, { Component } from 'react';
import PropTypes from "prop-types";

import './DataForm.css';
import DataFormUtils from "./DataFormUtils";

class DataForm extends Component {

    constructor(props) {
        super(props);
        this.commit = this.commit.bind(this);
        this.validate = this.validate.bind(this);
        this.commitListeners = [];
        this.validateListeners = [];

        this.state = {
            hasErrors: false,
            validated: false,
            dirty: false
        };

        this.bindObj = {
            commit: this.commit,
            validate: this.validate,
            getValue: () => {return this.props.formObject},
        }
    }

    componentWillMount() {
        if (typeof this.props.bind === 'function') {
            this.props.bind(this.bindObj);
        } else if (typeof this.props.bind !== 'undefined') {
            console.error("Invalid 'bind' property (not a function)", this.props.bind);
        }
    }

    componentDidMount() {
       // if (typeof this.props.onReady === 'function') {
       //     this.props.onReady();
       // }

    }

    getChildContext() {
        return {
            formParent: this,
            formObject: this.props.formObject,
            formViewMode: this.props.viewMode,
            formHorizontal: this.props.horizontal,
            formInlineEdit: this.props.inlineEdit,
            formColumns: this.props.columns,
            formConstraints: this.props.constraints,
            formAutoCommit: this.props.autoCommit
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
        this.validateListeners.push(listener);
    }
    removeValidateListener(listener) {
        for (let i = 0; i < this.validateListeners.length; i++) {
            if (this.validateListeners[i] === listener) {
                this.validateListeners.splice(i, 1);
            }
        }
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
        let className = "DataForm";
        if (this.props.viewMode) {
            className += " view-mode";
        }
        if (this.props.horizontal) {
            className += " horizontal";
        }
        if (this.state.hasErrors) {
            className += " is-invalid";
        } else {
            className += " is-valid";
        }
        return (
            <div className={className}>
                {this.props.children}
            </div>
        );
    }
}

DataForm.propTypes = {
    name: PropTypes.string,
    formObject: PropTypes.object,
    viewMode: PropTypes.bool,
    horizontal: PropTypes.bool,
    inlineEdit: PropTypes.bool,
    columns: PropTypes.arrayOf(PropTypes.shape({
        xs: PropTypes.number,
        sm: PropTypes.number,
        md: PropTypes.number,
        lg: PropTypes.number,
        xl: PropTypes.number
    })),
    constraints: PropTypes.object,
    autoCommit: PropTypes.bool,

    // Bind receives object of following shape:
    // {
    //    commit: function(),
    //    validate: function(options),
    //    getValue: function(), // only for fields
    //    setValue: function(value) // only for fields
    // }
    bind: PropTypes.func,
    validationStateChanged: PropTypes.func
};

DataForm.defaultProps = {
    horizontal: false,
    viewMode: false,
    inlineEdit: false,
    autoCommit: false
};
DataForm.childContextTypes = {
    formParent: PropTypes.object,
    formObject: PropTypes.object,
    formHorizontal: PropTypes.bool,
    formViewMode: PropTypes.bool,
    formInlineEdit: PropTypes.bool,
    formColumns: DataForm.propTypes.columns,
    formConstraints: DataForm.propTypes.constraints,
    formAutoCommit: PropTypes.bool
};

export default DataForm;
