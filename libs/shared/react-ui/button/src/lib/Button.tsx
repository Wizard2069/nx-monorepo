import React, { SyntheticEvent, useContext } from 'react';
import { MDBBtn } from 'mdbreact';

import './Button.module.scss';

export const ColorContext = React.createContext<any>(undefined);

/* eslint-disable-next-line */
export interface ButtonProps {
  handleClick?: (e: SyntheticEvent) => void;
  content?: string;
}

export const Button = (props: ButtonProps) => {
  const color = useContext(ColorContext);

  return (
    <MDBBtn size="sm" color={color} onClick={props.handleClick}>
      {props.content}
    </MDBBtn>
  );
};

export default Button;
