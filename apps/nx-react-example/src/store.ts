import { configureStore } from '@reduxjs/toolkit';
import { counterReducer } from '@htcompany/nx-react-example-feature-counter';
import { pokemonApi } from '@htcompany/nx-react-example-data-access-pokemon';
import { setupListeners } from '@reduxjs/toolkit/query';
import { postApi } from '@htcompany/nx-react-example-data-access-post';

export const store = configureStore({
  reducer: {
    counter: counterReducer,
    [pokemonApi.reducerPath]: pokemonApi.reducer,
    [postApi.reducerPath]: postApi.reducer,
  },
  // Additional middleware can be passed to this array
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat([pokemonApi.middleware, postApi.middleware]),
  devTools: process.env.NODE_ENV !== 'production',
  // Optional Redux store enhancers
  enhancers: [],
});

setupListeners(store.dispatch);
