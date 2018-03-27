

import { handleActions, combineActions } from 'redux-actions'

const _LOG_DEBUG = false;
const _LOG_INFO = false;
const _LOG_ERROR = false;

/*
 * Stateful actions for 'redux-actions'.
 *
 * Every action has three states:
 * - REQUEST
 * - SUCCESS
 * - ERROR
 *
 */

/**
 * Suffix for 'REQUEST' phase actions.
 * @type {string}
 */
const ACTION_REQUEST_SUFFIX = "_REQUEST";

/**
 * Suffix for 'SUCCESS' phase actions.
 * @type {string}
 */
const ACTION_SUCCESS_SUFFIX = "_SUCCESS";


/**
 * Suffix for 'ERROR' phase actions.
 * @type {string}
 */
const ACTION_ERROR_SUFFIX = "_ERROR";


/**
 * Construct a action name for 'REQUEST' phase: actionType + ACTION_REQUEST_SUFFIX
 * @param actionType
 * @returns {string}
 */
const requestAction = (actionType) => {
    return actionType + ACTION_REQUEST_SUFFIX;
};

/**
 * Construct a action name for 'SUCCESS' phase: actionType + ACTION_SUCCESS_SUFFIX
 * @param actionType
 * @returns {string}
 */
const successAction = (actionType) => {
    return actionType + ACTION_SUCCESS_SUFFIX;
};

/**
 * Construct a action name for 'ERROR' phase: actionType + ACTION_ERROR_SUFFIX
 * @param actionType
 * @returns {string}
 */
const errorAction = (actionType) => {
    return actionType + ACTION_ERROR_SUFFIX;
};
// const phaseTransition = (action) => {
//     return action + '_PHASE_TRANSITION';
// };


/**
 * Create a combined stateful action for the requested actionType.
 *
 * @param actionType
 * @returns {{toString}}
 */
export const statefulAction = (actionType) => {
    return combineActions(requestAction(actionType), successAction(actionType), errorAction(actionType));
};


const defaultRequestPhaseHandler = (state, action) => {
    const phase = action.meta && action.meta.phase;
    switch (phase) {
        case 'request':
            // return {...state, isWorking: true};
            return state;

        default:
            return state;
    }
};
const defaultErrorPhaseHandler = (state, action) => {
    const phase = action.meta && action.meta.phase;
    if (phase === 'error' || action.error) {
        // return {...state, isWorking: false};
        return state;
    } else {
        return state;
    }

};

// const defaultGetStatusMap = (state, actionType, action) => {
//
//     if (typeof(state.meta) === 'undefined') {
//         state.meta = {};
//     }
//     const meta = state.meta;
//     if (typeof(meta.actionStatus) === 'undefined') {
//         meta.actionStatus = {};
//     }
//     if (typeof(meta.actionStatus[actionType]) === 'undefined') {
//         meta.actionStatus[actionType] = {};
//     } else {
//         meta.actionStatus[actionType] = {...meta.actionStatus[actionType]};
//     }
//
//     return meta.actionStatus[actionType];
// };

export const getActionStatusDepth = (state, actionType, actionKey) => {
    if (state._actionStatus && state._actionStatus[actionType]) {
        if (actionKey) {
            return state._actionStatus[actionType][actionKey];
        } else {
            return state._actionStatus[actionType]._global;
        }
    }
};

export const isRequestPhase = (state, actionType, actionKey) => {
    return getActionStatusDepth(state, actionType, actionKey) > 0;
};


const _getActionStatusMap = (state, actionType) => {
    if (typeof(state._actionStatus) !== 'undefined') {
        return state._actionStatus[actionType];
    } else {
        return undefined;
    }
};

const _updateActionStatusMap = (state, actionType, statusMap) => {

    if (typeof(state._actionStatus) === 'undefined') {
        state._actionStatus = {};
    } else {
        state._actionStatus = {...state._actionStatus};
    }

    state._actionStatus[actionType] = statusMap;
};

const orElse = (value, defaultValue) => {
    return typeof(value) === 'undefined' ? defaultValue : value;
};

export const handleStatefulActions = (handlers, defaultState) => {
    for (let type in handlers) {
        if (!handlers.hasOwnProperty(type)) {
            continue;
        }
        const handler = handlers[type];

        if (typeof(handler) === 'object') {
            // Replace with custom logic:

            handlers[type] = (state, action) => {

                let requestPhaseHandler = handler['request'] || defaultRequestPhaseHandler;
                let successHandler = handler['success'] || handler['next'] || handler[0];
                let errorHandler = handler['error'] || handler['throw'] || defaultErrorPhaseHandler;


                // let error = !!action.error;
                // TODO what to do with error?

                let handlerDelegate;
                const phase = action.meta ? action.meta.phase : undefined;

                let actionDepthDelta = 0;

                switch (phase) {
                    case 'request':
                        handlerDelegate = requestPhaseHandler;
                        actionDepthDelta = 1;
                        break;
                    case 'success':
                        handlerDelegate = successHandler;
                        actionDepthDelta = -1;
                        break;
                    case 'error':
                        handlerDelegate = errorHandler;
                        action.error = true;
                        actionDepthDelta = -1;
                        // error = true;
                        break;
                    default:
                        if (_LOG_ERROR) console.error("Invalid phase: " + phase);
                        break;
                }

                let newState;
                if (typeof(handlerDelegate) === 'function') {
                    newState = handlerDelegate(state, action);
                    if (typeof(newState) === 'undefined') {
                        newState = {...state};
                    }

                    if (newState !== state) {
                        switch (phase) {
                            case 'request':
                                // if (!newState.isWorking) {
                                //     newState.isWorking = true;
                                // }
                                break;
                            case 'success':
                            case 'error':
                                // if (newState.isWorking) {
                                //     newState.isWorking = false;
                                // }
                                break;
                            default:
                                // NOP
                        }
                    }


                } else {
                    newState = state;
                }


                if (handler.trackStatus && actionDepthDelta !== 0) {

                    const actionType = action.type;

                    let phaselessAction;
                    if (actionType.endsWith(ACTION_REQUEST_SUFFIX)) {
                        phaselessAction = actionType.substring(0, actionType.length - ACTION_REQUEST_SUFFIX.length);
                    } else if (actionType.endsWith(ACTION_ERROR_SUFFIX)) {
                        phaselessAction = actionType.substring(0, actionType.length - ACTION_ERROR_SUFFIX.length);
                    } else if (actionType.endsWith(ACTION_SUCCESS_SUFFIX)) {
                        phaselessAction = actionType.substring(0, actionType.length - ACTION_SUCCESS_SUFFIX.length);
                    } else {
                        phaselessAction = actionType;
                    }

                    if (newState === state) {
                        newState = {...state};
                    }

                    let actionKey;
                    if (typeof(handler.trackStatusKey) === 'function' ) {
                        actionKey = handler.trackStatusKey(action);
                    } else if (typeof(handler.trackStatusKey) !== 'undefined') {
                        if (_LOG_ERROR) console.error("Invalid 'trackStatusKey' type: '" + typeof(handler.trackStatusKey) + "'; only 'function' is supported");
                    }

                    let statusMap = _getActionStatusMap(newState, phaselessAction);
                    if (typeof(statusMap) === 'undefined') {
                        statusMap = {
                            _global: actionDepthDelta,
                            [actionKey]: actionDepthDelta
                        };
                    } else {
                        statusMap = {
                            ...statusMap,
                            _global: orElse(statusMap._global, 0) + actionDepthDelta,
                            [actionKey]: orElse(statusMap[actionKey], 0) + actionDepthDelta,
                        };
                    }
                    _updateActionStatusMap(newState, phaselessAction, statusMap);

                }

                if (newState !== state) {
                    newState.stateSince = Date.now();
                }
                return newState;

            };
        } else {
            if (_LOG_DEBUG) console.log("Not handling as stateful action: '" + type + "'");

        }
    }


    return handleActions(handlers, defaultState);
};
