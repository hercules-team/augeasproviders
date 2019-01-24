# frozen_string_literal: true

shared_examples_for 'apache_setenv resource' do
  it { is_expected.to have_apache_setenv_resource_count(1) }

  it do
    is_expected.to contain_apache_setenv('FOO').only_with(
      'name'     => 'FOO',
      'ensure'   => 'present',
      'value'    => 'bar',
      'provider' => 'augeas',
    )
  end
end

shared_context 'apache_setenv' do
  it { is_expected.to have_apache_setenv_resource_count(0) }

  let :example_params do
    { 'FOO' => { 'value' => 'bar' } }
  end

  context 'when apache_setenv_hash is a Hash' do
    let(:params) { { apache_setenv_hash: example_params } }
    let(:facts) { {} }

    include_examples 'apache_setenv resource'
  end

  context 'when ::augeasproviders_apache_setenv_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_apache_setenv_hash: example_params } }

    include_examples 'apache_setenv resource'
  end
end
