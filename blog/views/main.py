from flask import request, redirect, url_for, render_template, Blueprint
from flask_login import login_required, current_user

from blog.models import User, Posts, Comments

from blog import app, db

mod = Blueprint('main', __name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/blog')
@login_required
def blog():
    posts = Posts.query.all()
    comments = Comments.query.all()
    users = User.query.all()
    return render_template('start_page.html', posts=posts, comments=comments, users=users)


@app.route('/blog/posts/')
@login_required
def blog_posts():
    posts = Posts.query.filter_by(user_id=current_user.id)
    return render_template('blog.html', posts=posts)


@app.route('/profile/')
@login_required
def profile():
    user = User.query.filter_by(id=current_user.id).first()
    return render_template('profile.html', user=user)


@app.route('/add_post')
@login_required
def add_post():
    return render_template('add_post.html')


@app.route('/add_comment/<int:id>')
def add_comment(id):
    return render_template('add_comment.html', post_id=id)


@app.route('/post_comment', methods=['POST'])
def post_comment():
    comment = Comments(sender=current_user.id, post_id=request.form['post_id'], content=request.form['comment'])
    if request.form['comment']:
        db.session.add(comment)
        db.session.commit()
        return redirect(url_for('blog'))


@app.route('/comments')
def commnets():
    return render_template('comments.html')

#
# @app.route('/post', methods=['POST'])
# @login_required
# def post():
#     post = Posts(title=request.form['title'], content=request.form['content'], user_id=current_user.id)
#     if request.form['title'] and request.form['content']:
#         db.session.add(post)
#         db.session.commit()
#     return redirect(url_for('blog'))


@app.route('/comment_delete/<int:id>', methods=['POST'])
def comment_delete(id):
    comment = Comments.query.get_or_404(id)
    db.session.delete(comment)
    db.session.commit()
    return redirect(url_for('blog'))


@app.route('/delete/<int:id>', methods=['POST'])
def remove(id):
    post = Posts.query.get_or_404(id)
    if post.user_id == current_user.id:
        db.session.delete(post)
        db.session.commit()
    return redirect(url_for('blog'))


if __name__ == "__main__":
    app.run()
