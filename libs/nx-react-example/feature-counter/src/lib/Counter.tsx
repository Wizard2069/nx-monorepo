import { useDispatch, useSelector } from 'react-redux';
import React, { SyntheticEvent } from 'react';
import {
  decrement,
  increment,
  incrementByAmount,
  selectCounterValue,
} from './counterSlice';
import { Button, ColorContext } from '@htcompany/shared-react-ui-button';

export const Counter = () => {
  const count = useSelector(selectCounterValue);
  const dispatch = useDispatch();

  const incrementCounter = (e: SyntheticEvent) => {
    dispatch(increment());
  };

  const decrementCounter = (e: SyntheticEvent) => {
    dispatch(decrement());
  };

  const incrementCounterByAmount = (e: SyntheticEvent) => {
    dispatch(incrementByAmount(2));
  };

  return (
    <ColorContext.Provider value="primary">
      <Button handleClick={decrementCounter} content="-" />
      <span className="mx-3 d-flex justify-content-center align-items-center">
        {count}
      </span>
      <Button handleClick={incrementCounter} content="+" />
      <Button handleClick={incrementCounterByAmount} content="+2" />
    </ColorContext.Provider>
  );
};

export default Counter;
