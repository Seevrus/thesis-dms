import axios from 'axios';
import { createAsyncThunk, createEntityAdapter, createSlice } from '@reduxjs/toolkit';

const documentsAdapter = createEntityAdapter();
const initialState = documentsAdapter.getInitialState();

export const downloadDocument = async (id) => {
  try {
    const response = await axios.post('/api/document/download.php', { documentId: id }, { responseType: 'blob' });
    return response.data;
  } catch (e) {
    const response = await e.response.data.text();
    const responseJSON = JSON.parse(response);
    throw new Error(responseJSON.message);
  }
};

export const fetchDocuments = createAsyncThunk(
  'documents/fetchDocuments',
  async (requestData, { rejectWithValue }) => {
    try {
      const response = await axios.post('/api/document/list.php', requestData);
      return response.data.documents;
    } catch (e) {
      return rejectWithValue(e.response.data);
    }
  },
);

const documentsSlice = createSlice({
  name: 'documents',
  initialState,
  reducers: {},
  extraReducers: {
    [fetchDocuments.fulfilled]: documentsAdapter.upsertMany,
  },
});

export const {
  selectById: selectDocumentById,
  selectIds: selectDocumentIds,
} = documentsAdapter.getSelectors((state) => state.documents);

export default documentsSlice.reducer;
