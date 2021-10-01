export interface PokemonAttribute {
  readonly name: string;
  readonly url: string;
}

export interface Pokemon {
  readonly id: number;
  readonly abilities: [
    {
      readonly ability: PokemonAttribute;
      readonly is_hidden: boolean;
      readonly slot: number;
    }
  ];
  readonly base_experience: number;
  readonly height: number;
  readonly weight: number;
  readonly species: PokemonAttribute;
  readonly sprites: {
    front_shiny: string;
  };
}
