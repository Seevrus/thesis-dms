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
  deleteDocument, downloadDocument, removeDeletedDocument, selectDocumentById,
} from '../../store/documentsSlice';

import information from '../../img/information.svg';
import paymentMethod from '../../img/payment-method.svg';

const { useState } = React;

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

  const {
    added,
    companyName,
    documentName,
    documentCategory,
    downloadedAt,
    validUntil,
  }: DocumentT = useAppSelector((state) => selectDocumentById(state, id));

  const [deleteSuccess, setDeleteSuccess] = useState('');
  const [deletable, setDeletable] = useState(!!downloadedAt);
  const [serverError, setServerError] = useState('');

  const formattedCompanyName = decode(companyName);
  const formattedDocumentCategory = decode(documentCategory);
  const formattedDocumentName = decode(documentName);

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

  const handleDownload = (e: React.MouseEvent) => {
    e.preventDefault();
    downloadDocument(id)
      .then((data) => {
        setServerError('');
        import('js-file-download')
          .then(
            ({ default: fileDownload }) => {
              fileDownload(data, `${formattedDocumentName}.pdf`);
              setTimeout(() => setDeletable(true), 3000);
            },
          );
      })
      .catch((err) => setServerError(err.message));
  };

  return (
    <Container className="letoltes_blokk mt-3">
      <Row>
        <Col className="col-md-2 align-self-center d-none d-md-block">
          <Image src={DOCUMENT_CATEGORY[formattedDocumentCategory]} thumbnail alt="Bérjegyzék ikon" />
        </Col>
        <Col className="col-sm-12 col-md-10">
          <ListGroup>
            <ListGroup.Item><strong>{formattedDocumentName}</strong></ListGroup.Item>
            <ListGroup.Item>
              Cég:
              {' '}
              {formattedCompanyName}
            </ListGroup.Item>
            <ListGroup.Item>
              Kategória:
              {' '}
              {formattedDocumentCategory}
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
          <Button variant="primary" onClick={handleDownload}>Letöltés</Button>
          {deletable && <Button variant="primary" onClick={handleDelete}>Törlés</Button>}
        </div>
      </div>
      <hr />
    </Container>
  );
};

export default SingleDocument;
