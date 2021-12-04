import axios from 'axios';
import { createAsyncThunk, createEntityAdapter, createSlice } from '@reduxjs/toolkit';
import { DocumentT, FetchDocumentsRequestT } from './documentsSliceTypes';
import { BaseResponseT } from '../commonTypes';
// eslint-disable-next-line import/no-cycle
import { RootState } from '../store';

const documentsAdapter = createEntityAdapter<DocumentT>();
const initialState = documentsAdapter.getInitialState();

export const deleteDocument = async (id: number) => {
  const response = await axios.post('/api/document/delete.php', { documentId: id });
  return response.data as BaseResponseT;
};

export const fetchDocuments = createAsyncThunk<DocumentT[], FetchDocumentsRequestT>(
  'documents/fetchDocuments',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/document/list.php', requestData);
      return response.data.documents;
    } catch (e) {
      return rejectWithValue(e.response.data as BaseResponseT);
    }
  },
);

export const isDocumentAvailable = async (documentId: number) => {
  const response = await axios.head(`/api/document/view.php?documentId=${documentId}`);
  return response.headers['content-type'] === 'application/pdf';
};

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
