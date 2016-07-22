
Description
---------------
Provide a daily feed of personalized items to improve yourself.

For example if you'd like to improve your knowledge about vim, the site would send you a link
to a screencast or article every day that you could watch or read and improve yourself.

The items are primarily distributed via e-mail, but we can think other directions as well.
For example Tweets or messages via WhatsApp, or an app that you install on a mobile device.
Or via Facebook.

There would be tracks or subject e.g. vim, python, puppet, etc. in the tech world, but there could
be totally different subjects. e.g. "wkipedia random" or "wikipedia given category".

The user can then give some feedback via links in the e-mail (or on our web site) telling us stuff like
* It was bad
* Too complex for me
* I already knew this
* ....

The user could also request an "additional dose".

Each daily entry can also include an additional, unrelated item that might be interesting for the person.

Each item should have an "estimated time needed" that can be provided by the user who submitted the item,
could be deducteed from the number of words on the page if it is an article or from the length of the
video if it is from YouTube.
It could be also adjusted by measuring how much time passed between the read clicking on the link to visit
the site (which will go through our site that will redirect) and the time the user provides feedback
by clicking on one of the feedback buttons.

Questions
--------------
Who should be able to add items to the database?
Who should be abel to categorize them?


Design
----------
* Register with an e-mail that needs to be verified. First with a web link, later maybe using an e-mail reply.
* Select a subject.
* Get the first dose.

user: email, password, registration date, email verification date, submitter(true/false) 
subscriptions:
  user
  keywords (all of them have to match so probably "advanced", "python" will make sense but "perl", "python" not),
  when to send
  items sent:
      item_id
      date
      feedback time and feedback value (the user might click on several of them so this should be a list)
items: URL, date added, user added, title, description, type (video, audio, text, ???), length


Related articles
-----------------
* [Learn Something New Every Day](http://www.lifehack.org/articles/featured/learn-something-new-every-day.html)
* [10 Techniques for Learning Something New Every Day](http://blog.sqwiggle.com/10-techniques-for-learning-something-new-every-day/)
* [10 Sites to Learn Something New in 10 Minutes a Day](http://mashable.com/2009/09/24/learning-resources/)
* [ZidBits](http://zidbits.com/)
* [Why Drip-Feeding Content is Crucial for ELearning](http://www.learndash.com/why-drip-feeding-content-is-crucial-for-elearning/)

Search terms when looking for existing solutions:
---------------
learn one thing a day
dripping learning

