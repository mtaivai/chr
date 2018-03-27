import React, { Component } from 'react';


import {
    Container,
    Row,
    Col,
    Nav,
    NavItem,
    NavLink,
    Button,
    Form,
    FormGroup,
    Label,
    Input,
    FormText} from 'reactstrap';

class PersonalInfoForm extends Component {
    render() {
        return (
            <Form>
                <h3>Henkilötiedot</h3>
                <Row>
                    <Col md={5} sm={5} xs={12}>
                        <FormGroup>
                            <Label for="firstName">Etunimi tai -nimet</Label>
                            <Input type={"text"} name="firstName" id="firstName" placeholder="Etunimi" />
                        </FormGroup>
                    </Col>
                    <Col md={7} sm={7} xs={12}>
                        <FormGroup>
                            <Label for="firstName">Sukunimi</Label>
                            <Input type={"text"} name="lastName" id="lastName" placeholder="Sukunimi" />
                        </FormGroup>
                    </Col>
                </Row>

                <Row>
                    <Col>
                        <FormGroup>
                            <Label for="email">Sähköposti</Label>
                            <Input type={"email"} name="email" id="email" placeholder="Sähköposti" />
                        </FormGroup>
                    </Col>
                </Row>

                <Row>
                    <Col md={3} sm={6} xs={12}>
                        <FormGroup>
                            <Label for="sex">Sukupuoli</Label>
                            <Input type={"select"} name="sex" id="sex" placeholder="Sukupuoli" >
                                <option></option>
                                <option value={"M"}>Mies</option>
                                <option value={"F"}>Nainen</option>
                            </Input>
                        </FormGroup>
                    </Col>
                    <Col>
                        <FormGroup>
                            <Label for="birthDate">Syntymäaika</Label>
                            <Input type={"date"} name="birthDate" id="birthDate" placeholder="Syntymäaika" />
                        </FormGroup>
                    </Col>
                </Row>
                <Row>
                    <Col>
                        <FormGroup>
                            <Label for="birthTown">Syntymäpaikka</Label>
                            <Input type={"text"} name="birthTown" id="birthTown" placeholder="Syntymäpaikka" />
                        </FormGroup>
                    </Col>

                    <Col>
                        <FormGroup>
                            <Label for="birthCountry">Syntymämaa</Label>
                            <Input type={"text"} name="birthCountry" id="birthCountry" placeholder="Syntymämaa" />
                        </FormGroup>
                    </Col>

                </Row>

            </Form>
        );
    }
}

export default PersonalInfoForm;
