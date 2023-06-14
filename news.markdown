---
layout: news
title: News
---

<header class="page-header">
  <h1 class="page-title">News</h1>
  <a href="/feed.xml" title="Subscribe to RSS Feed">
    <img src="/assets/images/rss-icon.svg" alt="RSS Icon">
  </a>
</header>

<section class="post-list">
  {% for post in site.posts %}
    {% include post.html post=post %}
  {% endfor %}
</section>