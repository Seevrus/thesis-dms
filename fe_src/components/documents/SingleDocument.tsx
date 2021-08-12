import { decode } from 'html-entities';
import * as React from 'react';
import {
  Button,
  Col,
  Container,
  Image,
  ListGroup,
  Row,
} from 'react-bootstrap';
import { useSelector } from 'react-redux';

import paymentMethod from '../../img/payment-method.svg';

import { selectDocumentById } from '../../store/documentsSlice';

interface Document {
  id: number,
  documentName: string,
  category: string,
  added: string,
  validUntil: string,
};

interface Props {
  id: number;
}

const SingleDocument = ({ id } : Props) => {
  const {
    added,
    category,
    documentName,
    validUntil
  }: Document = useSelector((state) => selectDocumentById(state, id));

  return (
    <Container className="letoltes_blokk mt-3">
      <Row>
        <Col className="col-md-2 align-self-center d-none d-md-block">
          <Image src={paymentMethod} thumbnail alt="Bérjegyzék ikon" />
        </Col>
        <Col className="col-sm-12 col-md-10">
          <ListGroup>
            <ListGroup.Item><strong>{decode(documentName)}</strong></ListGroup.Item>
            <ListGroup.Item>Kategória: {decode(category)}</ListGroup.Item>
            <ListGroup.Item>Hozzáadva: {added}</ListGroup.Item>
            {validUntil && <ListGroup.Item>Érvényes: {validUntil}</ListGroup.Item>}
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
};

export default SingleDocument;
