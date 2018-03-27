import validate from "validate.js/validate";

const _LOG_DEBUG = false;
const _LOG_INFO = false;
const _LOG_ERROR = false;


class DataFormUtils {

}


DataFormUtils.connectParent = (parent, child) => {


   if (typeof parent !== 'undefined') {

       if (typeof child.commit === 'function') {
           if (typeof parent.addCommitListener === 'function') {
               parent.addCommitListener(child.commit);
           } else {
               if (_LOG_ERROR) console.error("Parent context doesn't have addCommitListener function; can't listen for commit");
           }
       }

       if (typeof child.validate === 'function') {
           if (typeof parent.addValidateListener === 'function') {
               parent.addValidateListener(child.validate);
           } else {
               if (_LOG_ERROR) console.error("Parent context doesn't have addValidateListener function; can't listen for validation");
           }
       } else {
           if (_LOG_INFO) console.log("Child doesn't support validation");
       }



   } else {
       if (_LOG_ERROR) console.error("No parent context available; can't listen for commit or validate");
   }
};

DataFormUtils.disconnectParent = (parent, child) => {


    if (typeof parent !== 'undefined') {
        if (typeof child.commit === 'function') {
            if (typeof parent.removeCommitListener === 'function') {
                parent.removeCommitListener(child.commit);
            } else {
                if (_LOG_ERROR) console.error("Parent context doesn't have removeCommitListener function; can't unregister listener");
            }
        }
        if (typeof child.validate === 'function') {
            if (typeof parent.removeValidateListener === 'function') {
                parent.removeCommitListener(child.validate);
            } else {
                if (_LOG_ERROR) console.error("Parent context doesn't have removeValidateListener function; can't unregister listener");
            }
        }
    }

};

DataFormUtils.getComponentName = (component) => {
    if (typeof component === 'undefined' || component === null) {
        return undefined;
    }

    const typeName = component.constructor.name;
    let name;
    if (typeof component.name !== 'undefined' && component.name !== null) {
        name = component.name;
    } else if (typeof component.props === 'object') {
        name = component.props.name;
    } else {
        name = undefined;
    }
    return typeName + "(\"" + name + "\")";
};

DataFormUtils.groupCommit = (commitListeners) => {

    let result = true;
    // Dispatch to children
    for (let i = 0; i < commitListeners.length; i++) {
        const l = commitListeners[i];
        if (typeof l === 'function') {
            if (!l()) {
                result = false;
            }
        }
    }
    return result;
};

DataFormUtils.groupValidate = (component, options, changed) => {

    const componentName = DataFormUtils.getComponentName(component);

    // If this validation call is a result of trickle down from parent due to event from this
    // component validation, return the original result:
    const existingResult = DataFormUtils.stopRecursiveValidation(component, options);
    if (existingResult !== null) {
        // console.log("Already validated group: " + componentName);
        return existingResult;
    }

    // console.log("Validating group: " + componentName, options, component.validateListeners);
    let validateResult = {
        validationErrors: {},
        hasErrors: false,
        inputValid: true
    };
    // Dispatch to children

    const stopOnFirstError = (typeof options !== 'undefined' && options !== null && options.stopOnFirstError);

    const validateListeners = component.validateListeners;

    for (let i = 0; i < validateListeners.length; i++) {
        const l = validateListeners[i];
        if (typeof l === 'function') {
            const childResult = l(options);
            validate.extend(validateResult.validationErrors, childResult.validationErrors);
            if (typeof validateResult.hasErrors === 'undefined' || childResult.hasErrors) {
                validateResult.hasErrors = childResult.hasErrors;
            }
            if (typeof validateResult.inputValid === 'undefined' || !childResult.inputValid) {
                validateResult.inputValid = childResult.inputValid;
            }
        }
        if (validateResult.hasErrors && stopOnFirstError) {
            break;
        }
    }
    if (_LOG_DEBUG) console.log("Merged results of " + validateListeners.length + " validators in group " + componentName, validateResult);

    const wasValidated = component.state.validated;
    if (!component.state.validated) {
        component.setState({
            validated: true
        });
    }

    if (!wasValidated || validateResult.hasErrors !== component.state.hasErrors) {
        if (_LOG_DEBUG) console.log("Group validation state changed: " + componentName, validateResult);
        component.setState({
            hasErrors: validateResult.hasErrors,
            validated: true
        });

        if (typeof changed === 'function') {
            changed(validateResult);
        }

        if (typeof options.fireEvents === 'undefined' || options.fireEvents === null || options.fireEvents) {
            if (typeof component.props.validationStateChanged === 'function') {
                component.props.validationStateChanged(validateResult);
            }

            // Notify parent
            const parent = component.context.formParent;
            if (typeof parent === 'object' && typeof parent.childValidationStateChanged === 'function') {
                if (_LOG_DEBUG) console.log("Calling childValidationStateChanged from group: " + componentName, options);
                parent.childValidationStateChanged(validateResult, component);
            }
        }
    }
    return validateResult;
};

DataFormUtils.handleChildValidationStateChanged = (component, result, source) => {

    if (_LOG_DEBUG) {
        const componentName = DataFormUtils.getComponentName(component);
        console.log("childValidationStateChanged: " + componentName, result, source);
    }

    // Validate all children
    return DataFormUtils.groupValidate(
        component,
        {
            stopOnFirstError: true,
            fireEvents: false,
            source: {
                component: source,
                result: result
            }
        },
        (res) => {
            // Validation state changed, fire events and notify parent:

            if (typeof component.props.validationStateChanged === 'function') {
                component.props.validationStateChanged(res);
            }

            const parent = component.context.formParent;
            if (typeof parent === 'object' && typeof parent.childValidationStateChanged === 'function') {
                if (_LOG_DEBUG) console.log("Calling group parent childValidationStateChanged", res);
                parent.childValidationStateChanged(res, component);
            }
        });
};

DataFormUtils.stopRecursiveValidation = (component, options) => {
    // If this validation call is a result of trickle down from parent due to event from this
    // component validation, return the original result:
    if (typeof options !== 'undefined' && options !== null) {
        if (typeof options.source !== 'undefined' && options.source !== null) {
            if (options.source.component === component) {
                return options.source.result;
            } else {
                // Maybe under nested source:
                // return DataFormUtils.stopRecursiveValidation(component, options.source);
            }
        }
    }
    return null;
};

export default DataFormUtils;