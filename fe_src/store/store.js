import { configureStore } from '@reduxjs/toolkit';

import documentsSlice from './documentsSlice';
import usersSlice from './usersSlice';

const store = configureStore({
  reducer: {
    documents: documentsSlice,
    users: usersSlice,
  },
});

export default store;
