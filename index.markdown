---
layout: home
title: Home
image: /assets/images/logo.png
---

<img src="{{ "/assets/images/logo.png" | relative_url }}" alt="" class="img-fluid" />
<h1 class="visually-hidden">Alliance of Civic Technologists</h1>
<h2 class="text-secondary mb-3">We are thrilled to announce the formation of the Alliance of Civic Technologists (ACT).</h2>

{% if site.posts.size > 0 %}
  <div class="card card-body bg-light mb-3">
    {% for post in site.posts limit:1 %}
      <p class="mb-0"><strong>🎉 Latest Update ({{ post.date | date: "%B %-d, %Y" }})</strong>:
      <a href="{{ "/news" | relative_url }}">{{ post.title }}</a></p>
    {% endfor %}
  </div>
{% endif %}

<div markdown="1">
  The Alliance of Civic Technology (ACT) is a newly formed organization that will connect volunteer civic technology efforts, in both technology and advocacy, in their local communities. Our initial goal is to ensure the continuity and growth of civic technology volunteer communities across the United States, launching immediately to fill the gap left by the sunsetting of Code for America's Brigade program. <a href="/about">Learn more about ACT.</a>
</div>

<div class="row mb-5">
  <div class="col-md-6 text-center">
    <h3 class="h1 text-secondary">Join our mailing list!</h3>
    <p class="d-grid">
      <a href="https://eepurl.com/ithxXU" class="btn btn-primary">Join our mailing list</a>
    </p>
    <p><em>To stay in touch and/or join our efforts,  sign up for our mailing list.</em></p>
  </div>
  <div class="col-md-6 text-center">
    <h3 class="h1 text-secondary">Donate today!</h3>
    <p class="d-grid">
      <a href="https://opencollective.com/act-fund" class="btn btn-primary">Donate to ACT</a>
    </p>
    <p><em>To support our efforts financially, donations can be made on our Open Collective.</em></p>
  </div>
</div>

<!-- TODO
<h2>Member Organizations</h2>

{% include item-list.html items=site.data.organizations short=true %}


-->
