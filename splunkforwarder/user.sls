splunk_group:
  group.present:
    - name: splunk

splunk_user:
  user.present:
    - name: splunk
    - home: /opt/splunkforwarder
    - groups:
      - splunk
      {% for group in salt['pillar.get']('splunkforwarder:user_extra_groups', []).items()|sort -%}
      - {{ group }}
      {%- endfor %}
    - require:
      - group: splunk_group
