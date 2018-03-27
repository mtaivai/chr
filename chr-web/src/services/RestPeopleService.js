
import {delayedPromise} from "./mock-util";
import {PeopleActions} from "../actions";

class RestPeopleService {


    getPeople(request) {
        // offset = 0
        // count = 10

        console.log("REQ", request);


        const offset = 0;
        const count = 10;


        const options = {
            method: "get"
        };
        return delayedPromise(() => {
            return fetch(
                "http://localhost:8080/people?size=10&page=0", options)
                .then((response) => response.json());

        });
    }

    addPerson(request) {
        const url = "http://localhost:8080/people";
        const options = {
            method: 'post',
            body: JSON.stringify(request),
            cache: 'no-cache',
            headers: {
                'content-type': 'application/json'
            }
        };

        return fetch(url, options)
            .then((response) => {
                if (!response.ok) {
                    throw Error("Error: " + response.status);
                }
                const newPersonId = response.text();


                return {
                    newPersonId: newPersonId
                };
            })

    }


}

export default RestPeopleService;
