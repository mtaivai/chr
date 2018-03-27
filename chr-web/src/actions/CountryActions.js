
import services from '../services';
import { createAction } from 'redux-actions';


const CountryActions = {

    getCountries: createAction("COUNTRIES::GET", services.countries.getCountries),

};

export default CountryActions;