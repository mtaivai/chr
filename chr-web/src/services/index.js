
import RestPeopleService from "./RestPeopleService";
import RestCountryService from "./RestCountryService";

const services = {
    people: new RestPeopleService(),
    countries: new RestCountryService()
};


export default services;

