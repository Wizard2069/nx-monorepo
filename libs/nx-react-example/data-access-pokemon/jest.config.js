module.exports = {
  displayName: 'nx-react-example-data-access-pokemon',
  preset: '../../../jest.preset.js',
  transform: {
    '^.+\\.[tj]sx?$': 'babel-jest',
  },
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx'],
  coverageDirectory:
    '../../../coverage/libs/nx-react-example/data-access-pokemon',
};
