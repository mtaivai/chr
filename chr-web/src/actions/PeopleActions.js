
import services from '../services';
import { createAction } from 'redux-actions';

const personListActionMetaProvider = (...args) => {
    return {
        arguments: args
    };
};


const PeopleActions = {

    // TODO refactor to fetchPersonList_action + fetchPersonList()
    fetchPersonList: createAction("PERSON_LIST::FETCH", services.people.getPeople, personListActionMetaProvider),

    addPerson: createAction("PEOPLE::ADD_PERSON", services.people.addPerson, personListActionMetaProvider),



};

export default PeopleActions;