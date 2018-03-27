

// import { handleActions, combineActions } from 'redux-actions'
import * as navTreeActions from "../actions/navTree-actions";

import {handleStatefulActions, statefulAction} from "./redux-stateful-actions-OLD";
//
// const foo = (state, action) => {
//     const phase = action.meta.phase;
//     let newState = state;
//     switch (phase) {
//         case 'request':
//             newState = {...state, isFetching: true};
//             break;
//         case 'success':
//             newState = {
//                 ...state,
//                 isFetching: false,
//                 didInvalidate: state.didInvalidate,
//                 count: action.payload.count,
//                 offset: action.payload.offset,
//                 items: action.payload.items,
//                 totalCount: action.payload.totalCount
//             };
//             break;
//         case 'error':
//             newState = {...state, isFetching: false};
//             break;
//         default:
//             newState = state;
//     }
//     if (newState !== state) {
//         newState.stateSince = Date.now();
//     }
//     return newState;
// };
//

// const increaseFetchingCount( state) {
//
// }

const increaseFetchingCount = (state, map, key) => {

    if (typeof(map) === 'undefined' || typeof(key) === 'undefined') {
        return 0;
    }

    let newCount;
    const fetchingMap = state.meta.fetching[map];
    if (typeof(fetchingMap[key]) === 'undefined') {
        newCount = 1;
    } else {
        newCount = fetchingMap[key] + 1;
    }
    fetchingMap[key] = newCount;
    return newCount;
};

const navTree = handleStatefulActions({

    [statefulAction(navTreeActions.getChildren)]: {

        trackStatus: true,


        trackStatusKey(action) {
            return action.meta.arguments[0];
        },


        success(state, action)  {
            //console.log("navTree_getChildren success", state, action);

            const newState = {...state};

            const parentId = action.meta.arguments[0];

            const response = action.payload;
            const children = response.content;
            const childrenIds = [];
            newState.childrenIds[parentId] = childrenIds;
            children.forEach((child) => {
                childrenIds.push(child.id);
                newState.nodes[child.id] = child;
            });

            return newState;

        }
    },
    [statefulAction(navTreeActions.getNode)]: {
        success(state, action)  {

            const newState = {...state};

            const node = action.payload;
            newState.nodes[node.id] = node;

            return newState;
        }
    },
    [statefulAction(navTreeActions.getRootNode)]: {
        success(state, action) {
            const newState = {...state};

            const node = action.payload;
            newState.nodes[node.id] = node;
            newState.rootNode = node;

            return newState;
        }
    }
}, {
    rootNode: undefined,
    nodes: {},
    childrenIds: {}
});



export default navTree;
