const validateToken = (token: string) => {
  if (token === undefined || token === "") {
    return false;
  } else {
    return true;
  }
};

export default validateToken;
