import { MDBContainer, MDBRow, MDBSpinner } from 'mdbreact';
import { Counter } from '@htcompany/nx-react-example-feature-counter';
import { useGetPokemonByNameQuery } from '@htcompany/nx-react-example-data-access-pokemon';
import Post from './post/Post';

export const App = () => {
  const { data, error, isLoading } = useGetPokemonByNameQuery('ditto');

  return (
    <MDBContainer className="mt-5">
      <MDBRow className="d-flex justify-content-center">
        <Counter />
      </MDBRow>
      <MDBRow className="d-flex justify-content-center align-items-center">
        {error ? (
          <p style={{ color: 'red' }}>Oh no, there was an error</p>
        ) : isLoading ? (
          <MDBSpinner />
        ) : data ? (
          <>
            <h3>{data.species.name}</h3>
            <img src={data.sprites.front_shiny} alt={data.species.name} />
          </>
        ) : null}
      </MDBRow>
      <MDBRow>
        <Post />
      </MDBRow>
    </MDBContainer>
  );
};

export default App;
