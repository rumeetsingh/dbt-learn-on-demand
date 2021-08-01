{% snapshot mock_orders %}

{% set new_schema = 'dbt_rsingh' + '_snapshot' %}

{{
    config(
      target_database='analytics',
      target_schema=new_schema,
      unique_key='order_id',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from analytics.{{'dbt_rsingh'}}.mock_orders

{% endsnapshot %}