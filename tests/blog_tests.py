
from blog import app
import unittest


class BlogTestCase(unittest.TestCase):

    def test_index(self):
        tester = app.test_client(self)
        response = tester.get('/login', content_type='html/text')
        self.assertEqual(response.status_code, 200)

    # Ensure that the login page loads correctly
    def test_load_page(self):
        tester = app.test_client(self)
        response = tester.get('/login', content_type='html/text')
        self.assertTrue(b'Login' in response.data)

    # Ensure login behaves correctly given th correct credentials
    def test_correct_login(self):
        tester = app.test_client(self)
        response = tester.post('/login',
                               data=dict(email='user1@gmail.com', password='password'),
                               follow_redirects=True
                               )
        self.assertEqual(response.status_code, 200)

    # Ensure login behaves correctly given the incorrect credentials password not provided
    def test_incorrect_login_password_not_provided(self):
        tester = app.test_client(self)
        response = tester.post('/login',
                               data=dict(email='user2@gmail.com', password=''),
                               follow_redirects=False
                               )
        self.assertIn(b'Password not provided', response.data)

    # Ensure login behaves correctly given the incorrect credentials email not provided
    def test_incorrect_login_email_not_provided(self):
        tester = app.test_client(self)
        response = tester.post('/login',
                               data=dict(email='', password='password'),
                               follow_redirects=False
                               )
        self.assertIn(b'Email not provided', response.data)

    # Ensure logout behaves correctly
    def test_logout(self):
        tester = app.test_client(self)
        tester.post(
            '/login',
            data=dict(email='user1@gmail.com', password='password'),
            follow_redirects=True
        )
        response = tester.get('/logout', follow_redirects=True)
        self.assertEqual(response.status_code, 200)

    # Ensure that redirection to login page behaves correctly
    def test_redirect_to_login(self):
        tester = app.test_client(self)
        response = tester.get('/blog', follow_redirects=True)
        self.assertTrue(b'Please log in to access this page.' in response.data)

    # Ensure that logout when user is not in a system behaves correctly
    def test_logout_when_user_is_out_of_a_system(self):
        tester = app.test_client(self)
        response = tester.get('/logout')
        self.assertEqual(response.status_code, 302)


if __name__ == '__main__':
    unittest.main()
