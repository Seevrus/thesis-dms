import { configureStore } from '@reduxjs/toolkit';

// eslint-disable-next-line import/no-cycle
import documentsSlice from './documentsSlice';
// eslint-disable-next-line import/no-cycle
import usersSlice from './usersSlice';

const store = configureStore({
  reducer: {
    documents: documentsSlice,
    users: usersSlice,
  },
});

export default store;

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
