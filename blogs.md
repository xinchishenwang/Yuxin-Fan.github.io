---
layout: page
permalink: /blogs/index.html
title: Blogs
pubs:

  - author: "Jiafeng"
    title: "How to Use R(Basic Skills-1)"
    keywords: "Tag: R"
    month: "March"
    year: "2016"
    url: 2016-03-01-rSkills(1).html

  - author: "Jiafeng"
    title: "How to Use R(Basic Skills-2)"
    keywords: "Tag: R"
    month: "March"
    year: "2016"
    url: 2016-03-08-rSkills(2).html


  - author: "Jiafeng"
    title: "How to Use R(Basic Skills-3)"
    keywords: "Tag: R"
    month: "March"
    year: "2016"
    url: 2016-03-15-rSkills(3).html

  - author: "Jiafeng"
    title: "Best Subset Selection(R code)"
    keywords: "Tag: subset selection"
    month: "March"
    year: "2016"
    url: 2016-03-10-Best-subset-selection.html

  - author: "Jiafeng"
    title: "Ridge Regression(R code)"
    keywords: "Tag: ridge regression"
    month: "March"
    year: "2016"
    url: 2016-03-14-Ridge-Regression.html

  - author: "Jiafeng"
    title: "How to Use R to do Markov Chain Monte Carlo"
    keywords: "Tag: MCMC"
    month: "April"
    year: "2015"
    url: 2015-04-01-MCMC.html

  - author: "Jiafeng"
    title: "How to Use R to do Newton Iteration"
    keywords: "Tag: Newton Iteration"
    month: "April"
    year: "2015"
    url: 2015-04-01-Newton-Iteration.html
---

# Blogs

{% for pub in page.pubs %}
{% unless pub.hidden %}
  - {% if pub.url %} [{{pub.title}}]({{pub.url}}).
    {% else %} {{pub.title}}.
    {% endif %}{% if pub.type %}({{pub.type}})
    {% endif %}<br>
    {{pub.keywords}}; {{pub.month}}, {{pub.year}}.<br>
    {% if pub.type == 'Technical Report' %}{{pub.number}} 
    {% endif %}{% if pub.slides %}[Slides]({{pub.slides}}).
    {% endif %}
{% endunless %}
{% endfor %}

