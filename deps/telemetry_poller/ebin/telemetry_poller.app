{application,telemetry_poller,
             [{description,"Periodically collect measurements and dispatch them as Telemetry events."},
              {vsn,"0.5.1"},
              {registered,[]},
              {mod,{telemetry_poller_app,[]}},
              {applications,[kernel,stdlib,telemetry]},
              {env,[]},
              {modules,[telemetry_poller,telemetry_poller_app,
                        telemetry_poller_builtin,telemetry_poller_sup]},
              {licenses,["Apache 2.0"]},
              {links,[{"Github",
                       "https://github.com/beam-telemetry/telemetry_poller"}]}]}.
