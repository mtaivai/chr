import {delayedPromise} from './mock-util'

class RestCountryService {


    getCountries() {

        const options = {
            method: "get"
        };
        return delayedPromise(() => {
            return fetch(
                "http://localhost:8080/countries?size=999", options)
                .then((response) => response.json());

        }, 300);
    }


}

export default RestCountryService;
