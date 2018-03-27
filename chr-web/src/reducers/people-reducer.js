

import {fetchPeople, updatePerson} from "../actions";
import PeopleActions from '../actions/PeopleActions';

import {handleStatefulActions, statefulAction} from "./redux-stateful-actions";


const personList = handleStatefulActions({

    [statefulAction(PeopleActions.fetchPersonList)]: {

        trackStatus: true,


        trackStatusKey(action) {
            return action.meta.arguments[0];
        },

        success(state, action)  {
            return {
                ...state,
                numberOfElements: action.payload.numberOfElements,
                content: action.payload.content,
                pageNumber: action.payload.pageNumber,
                totalPages: action.payload.totalPages,
                totalElements: action.payload.totalElements,
                lastPage: action.payload.lastPage,
                firstPage: action.payload.firstPage,
                sort: action.payload.sort
            };
        }
    }

}, {
    numberOfElements: 0,
    content: [],
    pageNumber: 0,
    totalPages: 0,
    totalElements: 0,
    lastPage: true,
    firstPage: true
});



const people = handleStatefulActions({

    [statefulAction(PeopleActions.addPerson)]: {

        trackStatus: true,

        trackStatusKey(action) {
            return action.meta.arguments[0];
        },

        success(state, action)  {
            return {
                ...state
            };
        }
    }

}, {

});



export {personList, people};
