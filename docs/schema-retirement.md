# Issuer schema retirement

The unused Workflow broker provisioning profile, its config key, and its six
issuer tables have been removed from installer sources. Shared OAuth refresh
claim sources and both LONG binding tables remain required. The source catalog
and activation bundle in light-portal-event is retired too; no events are imported
by this source change.

Existing installations require user-run handling. Removing provisioning files
does not remove a client previously registered by them. Before deploying the
broker-free light-oauth, run this read-only preflight on the installer database
with its application schema selected:

```sql
SELECT client_id, active FROM auth_client_t
WHERE client_name = 'Workflow unattended broker';
SELECT to_regclass('auth_workflow_broker_t') AS retired_broker_table;
```

If the table is present, also count its rows before applying the retirement
patch. If the client exists, deactivate it through the Portal UI or recreate the
application database. Do not reuse the retired preparation script. A preserved
Portal database may also contain the retired Workflow setting. Check its
catalog property and active mappings/values without printing the value:

```sql
SELECT p.property_id, p.active AS property_active,
       (SELECT count(*) FROM product_version_config_property_t m
        WHERE m.property_id = p.property_id AND m.active) AS active_product_mappings,
       (SELECT count(*) FROM instance_property_t i
        WHERE i.property_id = p.property_id AND i.active) AS active_instance_values
FROM config_property_t p WHERE p.property_name = 'credentialBroker';
```

Deactivate any remaining instance value, product mapping, and catalog property
through Portal commands/UI, then publish and check a new Workflow snapshot.
Do not delete Portal projection rows with SQL.

For preserved databases, the required order is:

1. Complete that registration preflight and run the broker-free light-oauth.
2. Obtain `patch_20260928_04_retire_workflow_broker.sql` from the matching
   portal-db release and apply it to the application database in its selected
   schema. This installer does not ship migration patches.
3. Only then rerun the current portal-db `cascade-runtime.generated.sql` or schema synchronization
   that installs it. The new inventory fails validation against the old tables.
4. Deploy the updated hybrid-command and hybrid-query images. Check refresh,
   LONG register/close, and a global snapshot export/import round trip.
   A new hybrid image running before the drop patch rejects snapshot export with
   `Workflow broker retirement patch must run before snapshot export` if it
   discovers a retired table; complete step 2 before diagnosing export.

Merge portal-db to master before light-portal, whose CI consumes portal-db master.
Fresh installations use the complete canonical `postgres-db/init.sql` instead
of replaying historical patches. Regenerate it from the workspace using
`portal-config-loc/scripts/generate-postgres-init.py --installer`; the guard checks
the schema and seeds of all selected destinations before writing.

Private runtime data, any old credentials, and shared-volume cleanup remain
user-run. Disposable SQL installation checks do not establish live qualification.
