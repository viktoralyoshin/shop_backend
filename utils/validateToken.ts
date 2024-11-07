const validateToken = (token: string) => {
  if (token === undefined) {
    return false;
  } else {
    return true;
  }
};

export default validateToken;
