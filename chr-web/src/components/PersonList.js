import React, { Component } from 'react';

// import {
//     Container,
//     Row,
//     Col,
//     Nav as R_Nav,
//     NavItem as R_NavItem,
//     NavLink as R_NavLink,
//     Button,
//     Form,
//     FormGroup,
//     Label,
//     Input,
//     FormText} from 'reactstrap';

import {connect} from 'react-redux'
// import PropTypes from "prop-types";
// import RouterNav from "./nav/RouterNav";
//
// import {DataForm, DataFormGroup, DataFormField} from './dataform';

//import PersonalInfoForm from './PersonalInfoForm';
//import ContactInfoForm from './ContactInfoForm';

import { bindActionCreators } from 'redux'

import * as actions from "../actions"
import {PeopleActions} from '../actions';

import {isRequestPhase} from "../reducers/redux-stateful-actions";


class PersonList extends Component {

    // constructor(props) {
    //     super(props);
    // }

    componentWillMount() {
        //this.props.actions.fetchPeople();
        this.props.PeopleActions.fetchPersonList();
    }


    render() {

        // const person = {
        //     firstName: "Erkki",
        //     lastName: "Esimerkki",
        //     emailAddress: "erkki.esimerkki@example.com",
        //     nationality: "Suomi",
        //     sex: "M",
        //     address: {
        //         streetAddress1: "Esimerkkikatu 1 b 9",
        //         town: "Pikkukylä",
        //         zipCode: "12345",
        //         country: "Finland"
        //     }
        // };


        const createTableBody = () => {

            if (this.props.fetchingPeople) {
                return (
                    <tbody>
                        <tr>
                            <td colSpan={2}>Haetaan...</td>
                        </tr>
                    </tbody>
                );
            } else {
                const personList = this.props.personList;

                const rows = [];
                const count = personList.content.length;
                for (let i = 0; i < count; i++) {
                    const item = personList.content[i];
                    rows.push(
                        <tr key={i}>
                            <td>{item.firstName} {item.lastName}</td>
                            <td><pre>{JSON.stringify(item)}</pre></td>
                        </tr>
                    );
                }

                return (
                    <tbody>
                        {rows}
                    </tbody>
                );
            }

        };

        return (
            <div className={"PeoplePage"}>

                <table className={"table"}>
                    <thead>
                    <tr>
                        <th>Nimi</th>
                        <th>Organisaatio</th>
                    </tr>
                    </thead>
                    {
                        createTableBody()
                    }

                </table>
            </div>
        );

    }
}


const mapStateToProps = (state, ownProps) => {
    return {
        personList: state.personList,
        fetchingPeople: isRequestPhase(state.personList, PeopleActions.fetchPersonList)
    };
};

// const mapStateToProps = (state, ownProps) => {
//     return {
//         node: state.navTree.nodes[ownProps.nodeId],
//         childrenIds: state.navTree.childrenIds[ownProps.nodeId],
//         fetchingChildren: getActionStatusDepth(state.navTree, 'NAVTREE_GET_CHILDREN', ownProps.nodeId) > 0
//     };
// };

function mapDispatchToProps(dispatch) {
    return {
        PeopleActions: bindActionCreators(PeopleActions, dispatch)
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(PersonList);

