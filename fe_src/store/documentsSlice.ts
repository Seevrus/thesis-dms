import axios from 'axios';
import { createAsyncThunk, createEntityAdapter, createSlice } from '@reduxjs/toolkit';
import { DocumentRequestT, DocumentT, FetchDocumentsRequestT } from './documentsSliceTypes';
import { BaseResponseT } from './commonTypes';
// eslint-disable-next-line import/no-cycle
import { RootState } from './store';

const documentsAdapter = createEntityAdapter<DocumentT>();
const initialState = documentsAdapter.getInitialState();

export const deleteDocument = async (id: number) => {
  const response = await axios.post('/api/document/delete.php', { documentId: id });
  return response.data as BaseResponseT;
};

export const downloadDocument = async (id: number) => {
  try {
    const requestData: DocumentRequestT = { documentId: id };
    const response = await axios.post('/api/document/download.php', requestData, { responseType: 'blob' });
    return response.data as Blob;
  } catch (e) {
    const response = await e.response.data.text();
    const responseJSON = JSON.parse(response) as BaseResponseT;
    throw new Error(responseJSON.message);
  }
};

export const fetchDocuments = createAsyncThunk(
  'documents/fetchDocuments',
  async (requestData: FetchDocumentsRequestT, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/document/list.php', requestData);
      return response.data.documents as DocumentT[];
    } catch (e) {
      return rejectWithValue(e.response.data as BaseResponseT);
    }
  },
);

const documentsSlice = createSlice({
  name: 'documents',
  initialState,
  reducers: {
    removeDeletedDocument: documentsAdapter.removeOne,
  },
  extraReducers: (builder) => {
    builder.addCase(fetchDocuments.fulfilled, documentsAdapter.upsertMany);
  },
});

export const {
  selectById: selectDocumentById,
  selectIds: selectDocumentIds,
} = documentsAdapter.getSelectors((state: RootState) => state.documents);

export const { removeDeletedDocument } = documentsSlice.actions;

export default documentsSlice.reducer;
