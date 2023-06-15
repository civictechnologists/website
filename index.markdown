---
layout: home
---

<div class="container">
  <img src="{{ "/assets/images/logo.png" | relative_url }}" alt="" class="img-fluid" />
  <h1 class="visually-hidden">Alliance of Civic Technologists</h1>
  <h2 class="text-secondary mb-3">We are thrilled to announce the formation of the Alliance of Civic Technologists (ACT).</h2>

  {% if site.posts.size > 0 %}
      {% for post in site.posts limit:1 %}
        <div class="card card-body bg-light mb-3">
            <p class="mb-0"><strong>🎉 Latest Update ({{ post.date | date: "%B %-d, %Y" }})</strong>:
            <a href="{{ "/news" | relative_url }}">{{ post.title }}</a></p>
        </div>
      {% endfor %}
  {% endif %}

  <div markdown="1">

  ACT is a newly formed organization that will connect volunteer civic technology efforts, in both technology and advocacy, in their local communities. Our initial goal is to ensure the continuity and growth of civic technology volunteer communities across the United States, launching immediately to fill the gap left by the sunsetting of Code for America's Brigade Network.

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

  The original Brigades began with the idea that people want to give back to their local communities by tackling challenges that leverage their unique technical and advocacy skills. Civic technology volunteers joined these organizations to help people where we live. **ACT is a decentralized network of civic tech volunteer organizations, providing opportunities to connect, strategize, and grow.**

  **ACT is itself a community, one that builds with the communities we serve.** As civic technologists, we go where the work is, talking with users and understanding  their needs. The people we serve are our partners in this work. We forge friendships and learn from them as we share our skills and support their work.

  We advocate for changes in, both, technology and policies that enable more effective and equitable delivery of services to the people who rely on them.  We will  champion solutions that support the civil rights of our neighbors, as well as to call out those that would endanger them. **As technologists working at a local level while also having a national perspective, we aim to join coalitions pushing for progressive policies at every level of government.**

  Currently, ACT is speaking with civic technology leaders in 16 cities with many former Brigades in Seattle, Dayton, Boston, and Oakland already signing letters of intent to participate in the co-creation process. We will continue to recruit initial member organizations, with our first meeting in June. Leaders of local civic technology organizations interested in participating should reach out to ACT leadership via at hello(at)civictechnologists.org

  </div>
</div>
