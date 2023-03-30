{% test non_negative(model, column_name) %}

with validation as (

    select
	{{ column_name }} as test_field
    from {{ model }}

),

validation_errors as (

    select
        test_field
    from validation
    where test_field is not null and test_field < 0

)

select *
from validation_errors

{% endtest %}
