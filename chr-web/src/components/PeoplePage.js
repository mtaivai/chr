import React, { Component } from 'react';

import {
    Container,
    Row,
    Col,
    Nav as R_Nav,
    NavItem as R_NavItem,
    NavLink as R_NavLink,
    Button,
    ButtonGroup,
    Form,
    FormGroup,
    Label,
    Input,
    FormText,
    Modal, ModalBody, ModalHeader, ModalFooter} from 'reactstrap';

import {connect} from 'react-redux'
// import PropTypes from "prop-types";
// import RouterNav from "./nav/RouterNav";
//
// import {DataForm, DataFormGroup, DataFormField} from './dataform';

//import PersonalInfoForm from './PersonalInfoForm';
//import ContactInfoForm from './ContactInfoForm';

import { bindActionCreators } from 'redux'


import * as actions from "../actions"
import {PersonListActions} from '../actions';

import {isRequestPhase} from "../reducers/redux-stateful-actions";

import {DataForm, DataFormGroup, DataFormField} from './dataform';

import PersonList from './PersonList';
import {PeopleActions} from "../actions";
import PersonForm from "./PersonForm";
import SearchInput from "./SearchInput";
import LocalCountryService from "../services/LocalCountryService";
import CountryActions from "../actions/CountryActions";
import TagInput from './TagInput';
import services from "../services";


const cache = {};

class PeoplePage extends Component {

    constructor(props) {
        super(props);
        this.state = {
            addPersonModal: false,
            newPerson: {},
            addNewPersonValid: false
        };
        this.handleAddPerson = this.handleAddPerson.bind(this);
        this.cancelAddPerson = this.cancelAddPerson.bind(this);
        this.saveNewPerson = this.saveNewPerson.bind(this);
        this.personFormMounted = this.personFormMounted.bind(this);
    }

    componentDidMount() {
        // if (this.props.countries
        // this.props.CountryActions.getCountries();

    }


    handleAddPerson() {

        if (!this.state.addPersonModal) {
            this.setState({
                addPersonModal: true,
                newPerson: {
                }
            });
        }
    }
    cancelAddPerson() {
        this.setState({
            addPersonModal: false,
            newPerson: {}
        });
    }

    saveNewPerson() {
        // const result = this.commit();
        console.log("saveNewPerson", this.state.newPerson);
        const result = this.personForm.validate();
        console.log("Validation result: ", result);

        if (result.hasErrors) {
            console.error("The form has errors", result);
        } else {
            this.personForm.commit();
            console.log("New person after commit", this.state.newPerson);
        }
        this.props.PeopleActions.addPerson(this.state.newPerson);
        this.setState({
            addPersonModal: false,
            newPerson: {}
        });
    }
    personFormMounted(commit, validate) {
        this.commit = commit;
        this.validate = validate;

    }

    render() {


        // // TODO real cache (e.g. https://www.npmjs.com/package/memory-cache)
        // const cached = (name, resolve) => {
        //
        //     if (cache[name] != null) {
        //
        //         const item = cache[name];
        //
        //         switch (item.type) {
        //             case 'promise':
        //                 return item.value;
        //             case 'promise-resolved':
        //                 return new Promise((resolve) => {resolve(item.value)});
        //             case 'promise-rejected':
        //                 return new Promise((_, reject) => {reject(item.value)});
        //             default:
        //                 return item.value;
        //         }
        //     }
        //
        //     // Cache miss, resolve now:
        //
        //     const obj = resolve();
        //
        //     if (typeof obj === 'object') {
        //         if (typeof obj.then === 'function') {
        //             // Promise
        //             cache[name] = {type: 'promise', value: obj};
        //             return obj.then((response) => {
        //                 // Cache the response
        //                 cache[name] = {type: 'promise-resolved', value: response};
        //                 return response;
        //             }, (reason) => {
        //                 cache[name] = {type: 'promise-rejected', value: reason};
        //                 return reason;
        //             });
        //
        //         } else {
        //             // Plain object
        //             cache[name] = {type: 'object', value: obj};
        //             return obj;
        //         }
        //     } else if (typeof obj === 'function') {
        //         // function
        //         cache[name] = {type: 'function', value: obj};
        //         return obj;
        //     } else {
        //         // plain something
        //         cache[name] = {type: 'simple', value: obj};
        //         return obj;
        //     }
        //
        // };


        // return (
        //     <div className={"container"} style={{border: "1px solid red"}}>
        //         <div className={"row"}>
        //             <div className={"col"} style={{border: "1px solid green"}}>
        //                 <SearchInput
        //                     type="select"
        //                     cacheTimeout={10000}
        //                     useCache={true}
        //                     options={() => {
        //                         return services.countries.getCountries().then((r) => r.content);
        //                         //return cached('countries', () => services.countries.getCountries().then((r) => r.content))
        //                     }}
        //                     textProperty={"name"}
        //                     searchKeys={["name", "code"]}/>
        //                 <p>Som text</p>
        //             </div>
        //             <div className={"col"}>
        //                 Col 2
        //                 <input value={"Foo"}/>
        //             </div>
        //         </div>
        //     </div>
        // );

        return (
            <div className={"container"}>



                <form>
                <div className={"row"}>

                    {/*
                    <div className={"col-6"}>
                        <p>Multiple select list</p>

                        <TagInput multiple={true} settings={{ }}>
                            <option value={1} selected={true}>One</option>
                            <option value={2}>Two</option>
                            <option value={3}>Three</option>
                        </TagInput>
                    </div>

                    <div className={"col-6"}>
                        <p>Single select list</p>

                        <TagInput multiple={false} settings={{ }}>
                            <option value={1} selected={true}>One</option>
                            <option value={2}>Two</option>
                            <option value={3}>Three</option>
                        </TagInput>
                    </div>
*/}

                    <div className={"col-6"}>
                        <p>Multiple select list with dropdown</p>
                        <TagInput multiple={true} settings={{native: true, editMode: false, useDropDown: true}}>
                            <option value={100} selected={true}>100</option>
                            <option value={200} selected={true}>200</option>
                            <option value={300}>300</option>
                        </TagInput>
                    </div>

                    <div className={"col-6"}>

                        <p>Single select list with dropdown</p>
                        <TagInput name="b1" multiple={false} settings={{editMode: false, useDropDown: true}}>
                            <option value={1} selected={true}>One</option>
                            <option value={2}>Two</option>
                            <option value={3}>Three</option>
                        </TagInput>
                    </div>


                    <div className={"col-6"}>
                        <p>Multiple select list without dropdown, edit mode</p>
                        <TagInput multiple={true} settings={{editMode: true, useDropDown: false, showUnselected: true, showCheckboxesInViewMode: true}}>
                            <option value={1} selected={true}>One</option>
                            <option value={2}>Two</option>
                            <option value={3}>Three</option>
                        </TagInput>
                    </div>

                    <div className={"col-6"}>
                        <p>Single select list without dropdown, edit mode</p>
                        <TagInput name="b2" multiple={false} settings={{editMode: true, useDropDown: false, showUnselected: true, showCheckboxesInViewMode: true}}>
                            <option value={1} selected={true}>One</option>
                            <option value={2}>Two</option>
                            <option value={3}>Three</option>
                        </TagInput>
                    </div>

                    {/*
                    <div className={"col-6"}>
                        <p>search</p>
                        <TagInput search={true}>
                            <option value={1} selected={true}>One</option>
                            <option value={2}>Two</option>
                            <option value={3}>Three</option>
                        </TagInput>
                    </div>
                    */}
                </div>
                </form>
            </div>

        );

        return (
            <div className={"PeoplePage container"}>

                <Row>
                    <Col>
                        <ButtonGroup>
                            <Button color={"success"} onClick={this.handleAddPerson}>Lisää henkilö</Button>
                        </ButtonGroup>
                    </Col>
                </Row>
                <Row>
                    <Col>
                        <PersonList></PersonList>
                    </Col>
                </Row>


                <Modal isOpen={this.state.addPersonModal}  className={""}>
                    <ModalHeader toggle={this.cancelAddPerson}>Lisää uusi henkilö</ModalHeader>
                    <ModalBody>
                        <PersonForm person={this.state.newPerson}
                                    validationStateChanged={(vs) => this.setState({addNewPersonValid: vs.inputValid})}
                                    bind={(f) => this.personForm = f}/>
                    </ModalBody>
                    <ModalFooter>
                        <Button color="secondary" onClick={this.cancelAddPerson} >Peruuta</Button>
                        <Button color="primary"
                                disabled={!this.state.addNewPersonValid}
                                onClick={() => this.saveNewPerson()}>
                            Tallenna
                        </Button>

                    </ModalFooter>
                </Modal>
            </div>
        );
    }

}


const mapStateToProps = (state, ownProps) => {
    return {
        countries: state.countries
    };
};

function mapDispatchToProps(dispatch) {
    return {
        PeopleActions: bindActionCreators(PeopleActions, dispatch),
        CountryActions: bindActionCreators(CountryActions, dispatch),
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(PeoplePage);

