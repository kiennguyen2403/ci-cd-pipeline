const chai = require('chai');
const chaiHttp = require('chai-http');
const app = require('../app'); // Import your Express app

chai.use(chaiHttp);
const expect = chai.expect;

describe('App', () => {
  it('should return a 200 status code', (done) => {
    chai.request(app)
      .get('/')
      .end((err, res) => {
        expect(res).to.have.status(200);
        done();
      });
  });
});
