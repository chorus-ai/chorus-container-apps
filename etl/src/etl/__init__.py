import argparse

import prefect

from .ingest import ingest_etl
from .merge import merge_etl
from .network import index_network
from .vocabulary import upload_vocabulary

all_flows = [
    obj
    for (name, obj) in sorted(vars().items())
    if isinstance(obj, prefect.flows.Flow)]

parser = argparse.ArgumentParser()
subparsers = parser.add_subparsers(required=True)
for flow in all_flows:
    flow_parser = subparsers.add_parser(flow.name, help=flow.description)
    flow_parser.set_defaults(flow=flow)
    params = flow.parameters
    required_props = params.required or []
    for prop_name, prop in sorted(params.properties.items(), key=(lambda i: i[1]['position'])):
        choices=prop.get('enum')
        if prop_name in required_props:
            metavar = prop_name.upper()
            flow_parser.add_argument(prop_name, metavar=metavar, choices=choices)
        else:
            opt_name = '--' + prop_name.replace('_', '-')
            default = prop.get('default')
            if prop['type'] == 'boolean' and isinstance(default, bool):
                if default is False:
                    flow_parser.add_argument(opt_name, action='store_true', default=False)
                else:
                    opt_name = '--no-' + prop_name.replace('_', '-')
                    flow_parser.add_argument(opt_name, dest=prop_name, action='store_false', default=True)
            else:
                flow_parser.add_argument(opt_name, default=default, choices=choices)

def cli():
    ns = parser.parse_args()
    flow = ns.flow
    args = vars(ns)
    del args['flow']
    flow(**args)
