/* eslint-disable quote-props */
import { decode } from 'html-entities';
import * as React from 'react';
import {
  Alert,
  Button,
  Col,
  Container,
  Image,
  ListGroup,
  Row,
} from 'react-bootstrap';

import { useAppSelector, useAppDispatch } from '../../store/hooks';
import { DocumentT } from '../../store/documentsSliceTypes';
import {
  deleteDocument, removeDeletedDocument, selectDocumentById,
} from '../../store/documentsSlice';

import information from '../../img/information.svg';
import paymentMethod from '../../img/payment-method.svg';

interface Map {
  [key: string]: string | undefined
}

interface Props {
  id: number;
}

const DOCUMENT_CATEGORY: Map = {
  'Bérjegyzék': paymentMethod,
  'Tájékoztató': information,
};

const SingleDocument = ({ id } : Props) => {
  const dispatch = useAppDispatch();

  const [deleteSuccess, setDeleteSuccess] = React.useState('');
  const [serverError, setServerError] = React.useState('');

  const {
    added,
    category,
    title,
    downloadedAt,
    validUntil,
  }: DocumentT = useAppSelector((state) => selectDocumentById(state, id));
  const formattedCategory = decode(category);
  const formattedTitle = decode(title);

  const handleDelete = (e: React.MouseEvent) => {
    e.preventDefault();
    deleteDocument(id)
      .then(() => {
        setServerError('');
        setDeleteSuccess('Törlés sikeres.');
        setTimeout(() => dispatch(removeDeletedDocument(id)), 1000);
      })
      .catch((err) => setServerError(err.message));
  };

  return (
    <Container className="letoltes_blokk mt-3">
      <Row>
        <Col className="col-md-2 align-self-center d-none d-md-block">
          <Image src={DOCUMENT_CATEGORY[formattedCategory]} thumbnail alt="Bérjegyzék ikon" />
        </Col>
        <Col className="col-sm-12 col-md-10">
          <ListGroup>
            <ListGroup.Item><strong>{formattedTitle}</strong></ListGroup.Item>
            <ListGroup.Item>
              Kategória:
              {' '}
              {formattedCategory}
            </ListGroup.Item>
            <ListGroup.Item>
              Hozzáadva:
              {' '}
              {added}
            </ListGroup.Item>
            {validUntil && (
            <ListGroup.Item>
              Érvényes:
              {' '}
              {validUntil}
            </ListGroup.Item>
            )}
            {deleteSuccess && (
              <ListGroup.Item>
                <Alert variant="success">{deleteSuccess}</Alert>
              </ListGroup.Item>
            )}
            {serverError && (
              <ListGroup.Item>
                <Alert variant="danger">
                  Hiba:
                  {' '}
                  {serverError}
                </Alert>
              </ListGroup.Item>
            )}
          </ListGroup>
        </Col>
      </Row>
      <div className="d-flex justify-content-end mt-1">
        <div className="letolt">
          <Button
            variant="primary"
            href={`/api/document/view.php?documentId=${id}`}
            target="_blank"
          >
            Letöltés
          </Button>
          {downloadedAt && <Button variant="danger" onClick={handleDelete}>Törlés</Button>}
        </div>
      </div>
      <hr />
    </Container>
  );
};

export default SingleDocument;
