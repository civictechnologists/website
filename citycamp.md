---
layout: default
title: CityCamp
permalink: /citycamp/
leaflet: true
---

<header class="page-header">
  <h1 class="page-title">CityCamp</h1>
</header>

<h2 class="h4 fw-normal mt-2 mb-3">Where civics meets community</h2>

<p>CityCamp is a global movement of community-focused events that foster civic collaboration and innovation. These events bring people together to improve their communities. Everyone is welcome to join and share their ideas and skills to help make their city a better place.</p>

<header class="page-header mt-5">
  <h2 class="page-title" id="events">Upcoming CityCamps</h2>
</header>

{% assign today = site.current_date %}
{% assign sorted_cities = site.citycamp | sort: "city" %}

{% for city in sorted_cities %}
  {% assign city_has_upcoming = false %}
  {% assign next_event = nil %}
  {% assign next_event_date_str = "9999-99-99" %}
  {% for event in city.events %}
    {% if event.date %}
      {% assign edf = event.date | date: "%Y-%m-%d" %}
      {% if edf >= today %}
        {% assign city_has_upcoming = true %}
        {% if edf < next_event_date_str %}
          {% assign next_event_date_str = edf %}
          {% assign next_event = event %}
        {% endif %}
      {% endif %}
    {% endif %}
  {% endfor %}
  {% if city_has_upcoming %}
  <div class="card mb-3">
    <div class="card-body">
      <div class="text-danger fw-bold small text-uppercase">{{ next_event.date | date: "%B %-d, %Y" }}</div>
      <h5 class="card-title mb-1">{{ city.city }}{% if city.region %}, {{ city.region }}{% endif %}{% if city.country != "United States" %}, {{ city.country }}{% endif %}</h5>
      {% if next_event.name %}<div class="text-muted mb-1">{{ next_event.name }}</div>{% endif %}
      {% if next_event.venue %}<div class="small text-muted">{{ next_event.venue }}{% if next_event.address %} &mdash; {{ next_event.address }}{% endif %}</div>{% endif %}
      {% if next_event.organizer %}<div class="small text-secondary mt-1">Organized by {% if next_event.organizer_website %}<a href="{{ next_event.organizer_website }}" target="_blank" rel="noopener">{{ next_event.organizer }}</a>{% else %}{{ next_event.organizer }}{% endif %}</div>{% endif %}
      <a href="{{ city.url | relative_url }}" class="btn btn-primary btn-sm mt-3">Learn more &rarr;</a>
    </div>
  </div>
  {% endif %}
{% endfor %}

<div class="border border-dark mt-3">
  <div class="accordion accordion-flush" id="pastCityCampsAccordion">
    <div class="accordion-item">
      <h2 class="accordion-header" id="pastCityCampsHeading">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pastCityCampsCollapse" aria-expanded="false" aria-controls="pastCityCampsCollapse">
          Past CityCamps
        </button>
      </h2>
      <div id="pastCityCampsCollapse" class="accordion-collapse collapse" aria-labelledby="pastCityCampsHeading">
        <div class="accordion-body">
          <ul class="list-unstyled mb-0">
            {% for entry in site.data.citycamp_past_events %}
            <li class="d-flex justify-content-between py-1 border-bottom">
              <a href="{{ entry.url | relative_url }}">{{ entry.city }}{% if entry.region %}, {{ entry.region }}{% endif %}{% if entry.country != "United States" %}, {{ entry.country }}{% endif %}</a>
              <span class="text-muted small">{{ entry.date | date: "%B %-d, %Y" }}</span>
            </li>
            {% endfor %}
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<header class="page-header mt-5">
  <h2 class="page-title" id="world-citycamp-day">World CityCamp Day</h2>
</header>

<p><strong>World CityCamp Day is held on the third Saturday of September.</strong> While some cities hold CityCamps throughout the year, World CityCamp Day brings together the global CityCamp community to celebrate their efforts. Some cities hold official CityCamps at this time, while others use it to plan for a future event.</p>

<div class="row mt-5">
  <div class="col-md-6">
    <header class="page-header">
      <h2 class="page-title" id="who">Who is CityCamp for</h2>
    </header>
    <p>CityCamp is for everyone in the community:</p>
    <ul class="text-col-2 text-col-md-1">
      <li>Residents</li>
      <li>Elected officials</li>
      <li>Government staff</li>
      <li>Civic leaders</li>
      <li>Entrepreneurs</li>
      <li>Designers</li>
      <li>Technologists</li>
      <li>Journalists</li>
    </ul>
  </div>
  <div class="col-md-6">
    <header class="page-header">
      <h2 class="page-title" id="themes">Themes</h2>
    </header>
    <p>CityCamp themes vary by event, but generally focus on these interest areas:</p>
    <ul class="text-col-2">
      <li>Arts</li>
      <li>Civic engagement</li>
      <li>Civic technology</li>
      <li>Economics</li>
      <li>Education</li>
      <li>Environment</li>
      <li>Housing</li>
      <li>Human services</li>
      <li>Open government</li>
      <li>Safety</li>
      <li>Emergency management</li>
      <li>Health</li>
      <li>Transportation</li>
    </ul>
  </div>
</div>

<header class="page-header mt-5">
  <h2 class="page-title" id="cities">Participating Cities</h2>
</header>

{% include citycamp-map.html %}

<div class="accordion accordion-flush mt-3 border border-dark">
  <div class="accordion-item">
    <h3 class="accordion-header" id="citiesListHeading">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#citiesListCollapse" aria-expanded="false" aria-controls="citiesListCollapse">
        View all cities
      </button>
    </h3>
    <div id="citiesListCollapse" class="accordion-collapse collapse" aria-labelledby="citiesListHeading">
      <div class="accordion-body">
        <div class="row">
          <div class="col-6">
            <h4 class="h6 text-uppercase text-muted mt-0 mb-1">United States</h4>
            <ul class="list-unstyled mb-0">
              {% assign us_cities = sorted_cities | where: "country", "United States" %}
              {% for city in us_cities %}
              <li><a href="{{ city.url | relative_url }}">{{ city.city }}{% if city.region %}, {{ city.region }}{% endif %}</a></li>
              {% endfor %}
            </ul>
          </div>
          <div class="col-6">
            {% assign cities_by_country = sorted_cities | where_exp: "c", "c.country != 'United States'" | group_by: "country" | sort: "name" %}
            {% for group in cities_by_country %}
            <h4 class="h6 text-uppercase text-muted mb-1{% if forloop.first %} mt-0{% else %} mt-3{% endif %}">{{ group.name }}</h4>
            <ul class="list-unstyled mb-0">
              {% assign country_cities = group.items | sort: "city" %}
              {% for city in country_cities %}
              <li><a href="{{ city.url | relative_url }}">{{ city.city }}{% if city.region %}, {{ city.region }}{% endif %}</a></li>
              {% endfor %}
            </ul>
            {% endfor %}
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<header class="page-header mt-5">
  <h2 class="page-title" id="history">History</h2>
</header>

<p>The first CityCamp was organized by Kevin Curry and Jen Pahlka and held January 23&ndash;24, 2010, in Chicago, Illinois. Afterwards, Kevin and Luke Fretwell developed it as an open source brand so that anyone could host events anywhere. Since then, there have been self-organized CityCamp events worldwide.</p>

<header class="page-header mt-5">
  <h2 class="page-title" id="format">Format</h2>
</header>

<p>CityCamp is an <strong>unconference</strong>, where the people attending help plan the schedule.</p>
<ul>
  <li>Participants create and organize the agenda, with help from facilitators.</li>
  <li>Everyone takes part in the sessions instead of just listening.</li>
  <li>This makes it easier to share ideas and take real action.</li>
  <li>CityCamp focuses on local governments and community groups that affect our daily lives.</li>
  <li>The goal is to build local teams that come up with smart ways to improve city life.</li>
  <li>These ideas often involve design, better processes, and technology.</li>
  <li>The purpose is to make communities more open, welcoming, and easy to use.</li>
  <li>Though technology is a big part of CityCamp, it also includes other important topics.</li>
</ul>
