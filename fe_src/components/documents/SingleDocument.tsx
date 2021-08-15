import { decode } from 'html-entities';
import fileDownload from 'js-file-download';
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
import { useSelector } from 'react-redux';

import information from '../../img/information.svg';
import paymentMethod from '../../img/payment-method.svg';

import { downloadDocument, selectDocumentById } from '../../store/documentsSlice';

interface Document {
  id: number,
  documentName: string,
  category: string,
  added: string,
  downloadedAt: string,
  validUntil: string,
};

interface Map {
  [key: string]: string | undefined
};

interface Props {
  id: number;
}

const DOCUMENT_CATEGORY: Map = {
  "Bérjegyzék": paymentMethod,
  "Tájékoztató": information,
};

const SingleDocument = ({ id } : Props) => {
  const [downloadError, setDownloadError] = React.useState('');

  const {
    added,
    category,
    documentName,
    downloadedAt,
    validUntil
  }: Document = useSelector((state) => selectDocumentById(state, id));
  const formattedCategory = decode(category);
  const formattedDocumentName = decode(documentName);

  const handleDownload = (e: React.MouseEvent) => {
    e.preventDefault();
    downloadDocument(id)
      .then((data) => {
        setDownloadError('');
        fileDownload(data, `${formattedDocumentName}.pdf`)
      })
      .catch((e) => setDownloadError(e.message));
  };

  return (
    <Container className="letoltes_blokk mt-3">
      <Row>
        <Col className="col-md-2 align-self-center d-none d-md-block">
          <Image src={DOCUMENT_CATEGORY[formattedCategory]} thumbnail alt="Bérjegyzék ikon" />
        </Col>
        <Col className="col-sm-12 col-md-10">
          <ListGroup>
            <ListGroup.Item><strong>{formattedDocumentName}</strong></ListGroup.Item>
            <ListGroup.Item>Kategória: {formattedCategory}</ListGroup.Item>
            <ListGroup.Item>Hozzáadva: {added}</ListGroup.Item>
            {validUntil && <ListGroup.Item>Érvényes: {validUntil}</ListGroup.Item>}
            {downloadError && (
              <ListGroup.Item>
                <Alert variant="danger">Hiba: {downloadError}</Alert>
              </ListGroup.Item>
            )}
          </ListGroup>
        </Col>
      </Row>
      <div className="d-flex justify-content-end mt-1">
        <div className="letolt">
          <Button variant="primary" onClick={handleDownload}>Letöltés</Button>
          {downloadedAt && <Button variant="primary">Törlés</Button>}
        </div>
      </div>
      <hr />
    </Container>
  );
};

export default SingleDocument;
