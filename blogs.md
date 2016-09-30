---
layout: page
permalink: /blogs/index.html
title: Blogs
pubs:

  - author: "Jiafeng"
    title: "How to Use R to do Markov Chain Monte Carlo"
    keywords: "MCMC"
    month: "April"
    year: "2015"
    url: 2015-04-01-MCMC.html

---

# Blogs

{% for pub in page.pubs %}
{% unless pub.hidden %}
  - {% if pub.url %} [{{pub.title}}]({{pub.url}}).
    {% else %} {{pub.title}}.
    {% endif %}{% if pub.type %}({{pub.type}})
    {% endif %}<br>
    {{pub.keywords}}.<br>
    {% if pub.type == 'Technical Report' %}{{pub.number}} 
    {% endif %} {{pub.month}}, {{pub.year}}. {% if pub.slides %}[Slides]({{pub.slides}}).
    {% endif %}
{% endunless %}
{% endfor %}

