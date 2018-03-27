import React, { Component } from 'react';

import {
    Container,
    Row,
    Col,
    Nav as R_Nav,
    NavItem as R_NavItem,
    NavLink as R_NavLink,
    Button,
    Form,
    FormGroup,
    Label,
    Input,
    FormText} from 'reactstrap';

import {connect} from 'react-redux'
import PropTypes from "prop-types";
import RouterNav from "./nav/RouterNav";


import {DataForm, DataFormGroup, DataFormField} from './dataform';

//import PersonalInfoForm from './PersonalInfoForm';
//import ContactInfoForm from './ContactInfoForm';
import SearchInput from './SearchInput';

import services from "../services";

class PersonForm extends Component {
    render() {

        const person = this.props.person;

        const constraints = {
            firstName: {
                presence: {allowEmpty: false},
                length: {
                    maximum: 40
                }
            },
            lastName: {
                presence: {allowEmpty: false},
                length: {
                    maximum: 40
                }
            },
            nationality: {
                presence: {allowEmpty: false},
            }
        };


        const natOptions = [
            {name: 'Swedish', value: 'sv'},
            {name: 'English', value: 'en'}
        ];

        const bindNationality = (f) => {
            console.log("bindNationality", f);
            this.nationalityField = f;
        };

        const handleNationalitySelected = (option, value) => {
            console.log("Handle nationality selected", value);
            this.nationalityField.setValue(value);
        };

        return (
            <div className="PersonForm" >
                <DataForm name={"PersonForm"} formObject={person} viewMode={false} horizontal={false} inlineEdit={false}
                    constraints={constraints} autoCommit={false} bind={this.props.bind}
                    validationStateChanged={this.props.validationStateChanged}>

                    <DataFormGroup name={"name"}>
                        <DataFormField xs={12} sm={5} name={"firstName"} label={"Etunimi"} />
                        <DataFormField xs={12} sm={7} name={"lastName"} label={"Sukunimi"} />
                    </DataFormGroup>

                    <hr/>

                    <DataFormGroup name={"birthDateAndNationality"}>

                        <DataFormField sm={6} type={"date"} name={"birthDate"} label={"Syntymäaika"} />
                        <DataFormField sm={6} name={"sex"} type={"select"} label={"Sukupuoli"} >
                            <option/>
                            <option value={"F"} >Nainen</option>
                            <option value={"M"} >Mies</option>
                        </DataFormField>



                        <DataFormField name={"nationality"} type={"custom"} label={"Kansalaisuus"}
                            bind={bindNationality}>
                            <SearchInput
                                type="select"
                                useCache={true}
                                options={() => {
                                    return services.countries.getCountries().then((r) => r.content);
                                }}
                                onOptionSelected={handleNationalitySelected}
                                valueProperty={"code"}
                                textProperty={"name"}
                                searchKeys={["name", "code"]}/>

                        </DataFormField>
                        {/*
                        <DataFormField xs={6} name={"nationality"} type={"select"} label={"Kansalaisuus"}>
                            <option/>
                            <optgroup label={"Foo"}>
                                <option value={"FI"}>Suomi</option>
                                <option value={"SE"}>Ruotsi</option>
                            </optgroup>
                            <optgroup>
                                <option value={"UK"}>UK</option>
                                <option value={"US"}>US</option>
                            </optgroup>
                        </DataFormField>
                        */}
                    </DataFormGroup>

                    <hr/>

                    {/*
                    <DataFormGroup name={"address"} formObject={person.address}>
                        <DataFormField xs={12} name={"streetAddress1"} label={"Katuosoite"} />
                        <DataFormField xs={12} name={"streetAddress2"} label={"Katuosoite, lisärivi"} />

                        <DataFormField xs={6} horizontal={false} name={"town"} label={"Kapunki"} />
                        <DataFormField xs={6} horizontal={false} name={"zipCode"} label={"Postinumero"} />
                        <DataFormField xs={12} horizontal={false} name={"country"} label={"Maa"} />

                    </DataFormGroup>
*/}
                </DataForm>


            </div>
        );
    }
}
const mapStateToProps = (state) => {
    return {/*routerLocation: state.router.location*/};
};
// export default connect(mapStateToProps)(PersonPage);
export default PersonForm;