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

class ContactInfoForm extends Component {
    render() {
        return (
            <Form>
                <h3>Yhteystiedot</h3>
                <Row>
                    <Col>
                        <FormGroup>
                            <Label for="email">Sähköposti</Label>
                            <Input type={"email"} name="email" id="email" placeholder="Sähköposti" />
                        </FormGroup>
                    </Col>
                </Row>
            </Form>
        );
    }
}

export default ContactInfoForm;
