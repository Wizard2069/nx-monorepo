import React from 'react';
import './ExploreContainer.css';
import { MDBBtn, MDBContainer } from 'mdbreact';

// eslint-disable-next-line @typescript-eslint/no-empty-interface
interface ContainerProps {}

const ExploreContainer: React.FC<ContainerProps> = () => {
  return (
    <MDBContainer>
      <h1>Welcome to nx-ionic-react-example!</h1>
      <strong>Ready to create an app?</strong>
      <p>
        Start with Ionic{' '}
        <a
          target="_blank"
          rel="noopener noreferrer"
          href="https://ionicframework.com/docs/components"
        >
          UI Components
        </a>
      </p>
      <MDBBtn color="primary">Click me</MDBBtn>
    </MDBContainer>
  );
};

export default ExploreContainer;
