

import CountryActions from '../actions/CountryActions';

import {handleStatefulActions, statefulAction} from "./redux-stateful-actions";


const countries = handleStatefulActions({

    [statefulAction(CountryActions.getCountries)]: {

        trackStatus: true,


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



export {countries};
