
/opt/splunkforwarder/etc/certs:
  file:
    - directory
    - user: splunk
    - group: splunk
    - mode: 500

{% for filename, config in salt['pillar.get']('splunk:certs', {}).iteritems() %}

/opt/splunkforwarder/etc/certs/{{ filename }}:
  file:
    - managed
    - user: splunk
    - group: splunk
    - mode: {{ config.get('mode', 400) }}
    - contents_pillar: splunk:certs:{{ filename }}:content
    - require:
      - file: /opt/splunkforwarder/etc/certs
    - require_in:
      - service: splunkforwarder
    - watch_in:
      - service: splunkforwarder

{% endfor %}

