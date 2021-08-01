import React from 'react';
import {
  Button,
  Col,
  Container,
  Image,
  ListGroup,
  Row,
} from 'react-bootstrap';

import paymentMethod from '../../img/payment-method.svg';

const SingleDocument = () => (
  <Container className="letoltes_blokk mt-3">
    <Row>
      <Col className="col-md-2 align-self-center d-none d-md-block">
        <Image src={paymentMethod} thumbnail alt="Bérjegyzék ikon" />
      </Col>
      <Col className="col-sm-12 col-md-10">
        <ListGroup>
          <ListGroup.Item><strong>Bérjegyzék 2021. április</strong></ListGroup.Item>
          <ListGroup.Item>Hozzáadva: 2021. május 6.</ListGroup.Item>
          <ListGroup.Item>Érvényes: 2022. április 30.</ListGroup.Item>
        </ListGroup>
      </Col>
    </Row>
    <div className="d-flex justify-content-end mt-1">
      <div className="letolt">
        <Button variant="primary">Letöltés</Button>
        <Button variant="secondary" disabled>Törlés</Button>
      </div>
    </div>
    <hr />
  </Container>
);

export default SingleDocument;
