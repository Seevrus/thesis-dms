/* eslint-disable quote-props */
import { decode } from 'html-entities';
import { useEffect, useState } from 'react';
import {
  Alert,
  Button,
  Card,
  Col,
  Image,
  Row,
} from 'react-bootstrap';

import { Mapper } from '../../interfaces/common';
import { useAppSelector, useAppDispatch } from '../../store/hooks';
import { DocumentT } from '../../store/documents/documentsSliceTypes';
import {
  deleteDocument, isDocumentAvailable, removeDeletedDocument, selectDocumentById,
} from '../../store/documents/documentsSlice';

import './single-document.scss';
import information from '../../img/information.svg';
import paymentMethod from '../../img/payment-method.svg';

interface SingleDocumentProps {
  id: number;
}

const DOCUMENT_CATEGORY: Mapper = {
  'Bérjegyzék': paymentMethod,
  'Tájékoztató': information,
};

const SingleDocument = ({ id } : SingleDocumentProps) => {
  const dispatch = useAppDispatch();

  const [deleteSuccess, setDeleteSuccess] = useState('');
  const [isDownloadable, setIsDownloadable] = useState(false);
  const [serverError, setServerError] = useState('');

  useEffect(() => {
    isDocumentAvailable(id).then(setIsDownloadable);
  }, [id]);

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
    <Row>
      <Col>
        <Card>
          <Card.Header>
            <Card.Title as="h4">{formattedTitle}</Card.Title>
          </Card.Header>
          <Card.Body>
            <Row>
              <Col sm={8}>
                <p>
                  Kategória:
                  {' '}
                  {formattedCategory}
                </p>
                <p>
                  Hozzáadva:
                  {' '}
                  {added}
                </p>
                {validUntil
                  && (
                  <p>
                    Érvényes:
                    {' '}
                    {validUntil}
                  </p>
                  )}
                <Button
                  className="btn-fill"
                  disabled={!isDownloadable}
                  href={`./api/document/view.php?documentId=${id}`}
                  target="_blank"
                >
                  Letöltés
                </Button>
                {downloadedAt && (
                  <Button
                    className="btn-fill delete-btn"
                    variant="danger"
                    onClick={handleDelete}
                  >
                    Törlés
                  </Button>
                )}
              </Col>
              <Col sm={4} className="d-none d-sm-block float-right">
                <div className="card-image">
                  <Image
                    className="document-img"
                    src={DOCUMENT_CATEGORY[formattedCategory]}
                    thumbnail
                    alt="Bérjegyzék ikon"
                  />
                </div>
              </Col>
            </Row>
            <Row>
              {deleteSuccess && (
              <Alert variant="success">{deleteSuccess}</Alert>
              )}
              {serverError && (
              <Alert variant="danger">
                Hiba:
                  {' '}
                {serverError}
              </Alert>
              )}
            </Row>
          </Card.Body>
        </Card>
      </Col>
    </Row>
  );
};

export default SingleDocument;
