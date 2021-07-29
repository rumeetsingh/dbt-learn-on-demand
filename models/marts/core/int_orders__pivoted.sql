{%- set pms = ['bank_transfer','coupon','credit_card','gift_card'] -%}

with payments as (
    select * from {{ ref('stg_payments') }}
),

pivoted as (
    select 
        order_id,
        {% for pm in pms -%}
        sum(case when payment_method = '{{ pm }}' then amount else 0 end) as {{ pm }}_amount
        {%- if not loop.last -%}
            ,
        {%- endif %}
        {% endfor -%}

    from payments
    where status = 'success'
    group by 1
)

select * from pivoted